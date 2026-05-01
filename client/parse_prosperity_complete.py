#!/usr/bin/env python3
"""
Complete parser for Prosperity Bank locations.
"""

import re
from typing import Dict, List, Optional

def normalize_id(city: str, address: str, branch_suffix: str = "") -> str:
    """Generate unique ID: prosperity_[street]_[city] or prosperity_[city]_[suffix]"""
    parts = []
    
    # Extract street name (first word after number, skip directionals)
    addr_words = address.split()
    street_word = None
    for i, word in enumerate(addr_words):
        if word.upper() in ['N', 'S', 'E', 'W', 'N.', 'S.', 'E.', 'W.', 'NORTH', 'SOUTH', 'EAST', 'WEST']:
            continue
        if word and word[0].isalpha():
            street_word = word.lower().rstrip('.')
            break
    
    if street_word:
        parts.append(street_word)
    
    # Add city
    city_clean = city.lower().replace(' ', '_').replace("'", "").replace('.', '')
    parts.append(city_clean)
    
    # Add suffix if needed
    if branch_suffix:
        parts.append(branch_suffix)
    
    # Handle duplicates by checking if we need a number
    base_id = 'prosperity_' + '_'.join(parts)
    return base_id

def parse_entry(entry: str) -> Optional[Dict]:
    """Parse a single location entry."""
    entry = entry.strip()
    if not entry or len(entry) < 20:
        return None
    
    # Remove "Call Now Get Directions"
    entry = re.sub(r'\s*Call Now Get Directions\s*', '', entry, flags=re.IGNORECASE)
    
    # Find city, state, zip: "City, ST ZIP"
    # City should be a proper noun (capitalized), not part of address
    # Look for pattern: word(s) ending with comma, then state, then zip
    city_match = re.search(r'([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*),\s+([A-Z]{2})\s+(\d{5})', entry)
    if not city_match:
        return None
    
    city = city_match.group(1).strip()
    state = city_match.group(2)
    zip_code = city_match.group(3)
    
    # Extract phone: (XXX) XXX-XXXX or (800) 531-1401
    phone = None
    phone_patterns = [
        r'\((\d{3}|800)\)\s+(\d{3}[- ]?\d{4})',
        r'\((\d{3})\)\s+(\d{3})\s+(\d{4})',
    ]
    
    for pattern in phone_patterns:
        phone_match = re.search(pattern, entry)
        if phone_match:
            area = phone_match.group(1)
            if len(phone_match.groups()) == 3:
                num = f"{phone_match.group(2)}-{phone_match.group(3)}"
            else:
                num = phone_match.group(2).replace(' ', '')
                if '-' not in num and len(num) == 7:
                    num = f"{num[:3]}-{num[3:]}"
            phone = f"({area}) {num}"
            break
    
    # Get text before city - this should be the address
    before_city = entry[:city_match.start()].strip()
    
    # Remove leading number (entry number, not address number)
    # But be careful - we want to keep address numbers
    # The pattern is: "number Prosperity Bank" so remove that
    before_city = re.sub(r'^\d+\s+Prosperity Bank', 'Prosperity Bank', before_city)
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
        # Regular branch - remove "Prosperity Bank"
        before_city = re.sub(r'Prosperity Bank\s*', '', before_city, flags=re.IGNORECASE).strip()
    
    # Remove distance (X.X mi)
    before_city = re.sub(r'\d+\.\d+\s+mi\s+', '', before_city)
    
    # This should now be just the address
    address_part = before_city.strip()
    
    # Split Suite/Ste
    address_line1 = address_part
    address_line2 = None
    
    # Match Suite, Ste, Ste., or # patterns - be more flexible
    suite_patterns = [
        (r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)', 2),
        (r'\s+Ste\s*(\d+)', 1),
        (r'\s+Suite\s*([A-Za-z0-9#]+)', 1),
    ]
    
    for pattern, group_idx in suite_patterns:
        suite_match = re.search(pattern, address_part, re.IGNORECASE)
        if suite_match:
            pos = suite_match.start()
            address_line1 = address_part[:pos].strip()
            suite_text = suite_match.group(0).strip()
            # Normalize
            if suite_text.startswith('Ste '):
                address_line2 = 'Ste ' + (suite_match.group(group_idx) if group_idx <= len(suite_match.groups()) else suite_text.split()[-1])
            elif suite_text.startswith('Ste.'):
                address_line2 = 'Ste. ' + (suite_match.group(group_idx) if group_idx <= len(suite_match.groups()) else suite_text.split()[-1])
            elif suite_text.startswith('Ste'):
                address_line2 = 'Ste ' + (suite_match.group(group_idx) if group_idx <= len(suite_match.groups()) else suite_text.split()[-1])
            else:
                address_line2 = suite_text
            break
    
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
        # Normalize separators - replace · with newline for better formatting
        operating_hours = operating_hours.replace(' · ', '\\n')
    
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
    """Parse all locations from text."""
    locations = []
    seen = set()
    
    # Split by entries - look for pattern: number + "Prosperity Bank"
    # The entries are separated by numbers followed by "Prosperity Bank"
    # Use a more robust splitting approach
    
    # Find all matches of "number Prosperity Bank"
    matches = list(re.finditer(r'\d+\s+Prosperity Bank', text))
    
    for i, match in enumerate(matches):
        start = match.start()
        # End is either next match or end of text
        if i + 1 < len(matches):
            end = matches[i + 1].start()
        else:
            end = len(text)
        
        entry = text[start:end].strip()
        loc = parse_entry(entry)
        
        if loc:
            # Deduplicate by address + city + state + zip
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
            hours = loc['operatingHours'].replace("'", "\\'")
            lines.append(f"        operatingHours: '{hours}',")
        if loc.get('notes'):
            lines.append(f"        notes: '{loc['notes']}',")
        lines.append("      ),")
        lines.append("")
    
    return '\n'.join(lines)

if __name__ == '__main__':
    import sys
    
    # Read input
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            text = f.read()
    else:
        text = sys.stdin.read()
    
    locations = parse_all(text)
    print(f"# Parsed {len(locations)} locations", file=sys.stderr)
    print(generate_dart(locations))
