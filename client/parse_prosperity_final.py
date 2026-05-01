#!/usr/bin/env python3
"""
Parse Prosperity Bank locations - improved version.
"""

import re
from typing import Dict, List, Optional

def normalize_id(city: str, address: str, branch_suffix: str = "") -> str:
    """Generate a unique ID."""
    parts = []
    
    # Get first significant word from address
    addr_words = address.split()
    if addr_words:
        # Skip directional prefixes
        start_idx = 0
        if addr_words[0].upper() in ['N', 'S', 'E', 'W', 'N.', 'S.', 'E.', 'W.']:
            start_idx = 1
        if start_idx < len(addr_words):
            street = addr_words[start_idx].lower().rstrip('.')
            parts.append(street)
    
    # Add city
    city_clean = city.lower().replace(' ', '_').replace("'", "").replace('.', '')
    parts.append(city_clean)
    
    # Add suffix if needed
    if branch_suffix:
        parts.append(branch_suffix)
    
    return 'prosperity_' + '_'.join(parts)

def parse_entry(entry: str) -> Optional[Dict]:
    """Parse a single location entry."""
    entry = entry.strip()
    if not entry or len(entry) < 20:
        return None
    
    # Remove "Call Now Get Directions"
    entry = re.sub(r'\s*Call Now Get Directions\s*', '', entry, flags=re.IGNORECASE)
    
    # Find city, state, zip: "City, ST ZIP"
    city_match = re.search(r'([A-Z][A-Za-z\s\.]+?),\s+([A-Z]{2})\s+(\d{5})', entry)
    if not city_match:
        return None
    
    city = city_match.group(1).strip()
    state = city_match.group(2)
    zip_code = city_match.group(3)
    
    # Extract phone: (XXX) XXX-XXXX or (800) 531-1401
    phone = None
    phone_match = re.search(r'\((\d{3}|800)\)\s+(\d{3}[- ]?\d{4})', entry)
    if phone_match:
        area = phone_match.group(1)
        num = phone_match.group(2).replace(' ', '')
        if '-' not in num and len(num) == 7:
            phone = f"({area}) {num[:3]}-{num[3:]}"
        else:
            phone = f"({area}) {num}"
    
    # Get text before city
    before_city = entry[:city_match.start()].strip()
    
    # Remove leading number
    before_city = re.sub(r'^\d+\s+', '', before_city)
    
    # Check branch type
    branch_name = 'Prosperity Bank'
    notes = None
    branch_suffix = ''
    
    if 'Prosperity Bank - ATM' in before_city:
        branch_name = 'Prosperity Bank - ATM'
        notes = 'ATM Only'
        branch_suffix = 'atm'
        before_city = before_city.replace('Prosperity Bank - ATM', '').strip()
    elif 'Prosperity Bank - Drive Thru Only' in before_city or 'Prosperity Bank - Drive-Thru Only' in before_city:
        branch_name = 'Prosperity Bank - Drive Thru Only'
        notes = 'Drive-Thru Only'
        branch_suffix = 'drive_thru'
        before_city = re.sub(r'Prosperity Bank\s*-\s*Drive[\s-]?Thru Only', '', before_city, flags=re.IGNORECASE).strip()
    elif 'Prosperity Bank - Lobby Only' in before_city:
        branch_name = 'Prosperity Bank - Lobby Only'
        notes = 'Lobby Only'
        branch_suffix = 'lobby'
        before_city = before_city.replace('Prosperity Bank - Lobby Only', '').strip()
    else:
        # Regular branch
        before_city = re.sub(r'Prosperity Bank\s*', '', before_city, flags=re.IGNORECASE).strip()
    
    # Remove distance (X.X mi)
    before_city = re.sub(r'\d+\.\d+\s+mi\s+', '', before_city)
    
    # This should now be just the address
    address_part = before_city.strip()
    
    # Split Suite/Ste
    address_line1 = address_part
    address_line2 = None
    
    # Match Suite, Ste, Ste., or # patterns
    suite_match = re.search(r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)', address_part, re.IGNORECASE)
    if suite_match:
        pos = suite_match.start()
        address_line1 = address_part[:pos].strip()
        suite_text = suite_match.group(0).strip()
        # Normalize
        if suite_text.startswith('Ste '):
            address_line2 = 'Ste ' + suite_match.group(2)
        elif suite_text.startswith('Ste.'):
            address_line2 = 'Ste. ' + suite_match.group(2)
        elif suite_text.startswith('Ste'):
            address_line2 = 'Ste ' + suite_match.group(2)
        else:
            address_line2 = suite_text
    
    # Extract operating hours (after city/state/zip and phone)
    after_city = entry[city_match.end():].strip()
    
    # Remove phone if present
    if phone:
        after_city = after_city.replace(phone, '', 1).strip()
    
    # Remove any remaining phone patterns
    after_city = re.sub(r'\([0-9]{3}\)\s+[0-9]{3}[- ]?[0-9]{4}', '', after_city).strip()
    
    operating_hours = None
    if after_city and (after_city.startswith('Lobby:') or after_city.startswith('Drive') or 
                      'Open' in after_city or 'Closed' in after_city):
        operating_hours = after_city
        # Normalize separators
        operating_hours = operating_hours.replace(' · ', ' ')
    
    # Generate ID
    location_id = normalize_id(city, address_line1, branch_suffix)
    
    return {
        'id': location_id,
        'branchName': branch_name,
        'addressLine1': address_line1,
        'addressLine2': address_line2,
        'city': city,
        'state': state,
        'zip': zip_code,
        'phone': phone,
        'operatingHours': operating_hours,
        'notes': notes,
    }

def parse_all(text: str) -> List[Dict]:
    """Parse all locations."""
    locations = []
    seen = set()
    
    # Split by entries starting with number + "Prosperity Bank"
    # More flexible pattern
    pattern = r'\d+\s+Prosperity Bank[^0-9]*?(?=\d+\s+Prosperity Bank|$)'
    
    matches = re.finditer(pattern, text, re.DOTALL)
    
    for match in matches:
        entry = match.group(0).strip()
        loc = parse_entry(entry)
        
        if loc:
            # Deduplicate
            key = (loc['addressLine1'], loc.get('addressLine2'), loc['city'], loc['state'], loc['zip'])
            if key not in seen:
                seen.add(key)
                locations.append(loc)
    
    return locations

def generate_dart(locations: List[Dict]) -> str:
    """Generate Dart code."""
    lines = []
    
    for i, loc in enumerate(locations, 1):
        comment = f"// Location {i}: {loc['city']}"
        if loc.get('addressLine2'):
            comment += f" ({loc['addressLine2']})"
        
        lines.append(f"      {comment}")
        lines.append("      _createLocation(")
        lines.append(f"        id: '{loc['id']}',")
        lines.append(f"        clientId: clientId,")
        lines.append(f"        clientName: clientName,")
        lines.append(f"        branchName: '{loc['branchName']}',")
        lines.append(f"        addressLine1: '{loc['addressLine1']}',")
        if loc.get('addressLine2'):
            lines.append(f"        addressLine2: '{loc['addressLine2']}',")
        lines.append(f"        city: '{loc['city']}',")
        lines.append(f"        state: '{loc['state']}',")
        lines.append(f"        zip: '{loc['zip']}',")
        if loc.get('phone'):
            lines.append(f"        phone: '{loc['phone']}',")
        if loc.get('operatingHours'):
            hours = loc['operatingHours'].replace("'", "\\'").replace('\n', '\\n')
            lines.append(f"        operatingHours: '{hours}',")
        if loc.get('notes'):
            lines.append(f"        notes: '{loc['notes']}',")
        lines.append("      ),")
        lines.append("")
    
    return '\n'.join(lines)

if __name__ == '__main__':
    import sys
    text = sys.stdin.read() if len(sys.argv) == 1 else open(sys.argv[1], 'r', encoding='utf-8').read()
    locations = parse_all(text)
    print(f"# Parsed {len(locations)} locations", file=sys.stderr)
    print(generate_dart(locations))
