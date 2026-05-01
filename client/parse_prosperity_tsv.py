#!/usr/bin/env python3
"""
Parse Prosperity Bank locations from TSV/CSV format.
"""

import re
from typing import Dict, List, Optional

def parse_line(line: str) -> Optional[Dict]:
    """Parse a single line of TSV data."""
    if not line.strip():
        return None
    
    # Split by tabs
    parts = line.split('\t')
    if len(parts) < 6:
        return None
    
    branch_id = parts[0].strip()
    address = parts[1].strip()
    branch_name = parts[5].strip() if len(parts) > 5 else branch_id
    contact_name = parts[6].strip() if len(parts) > 6 else None
    phone = parts[7].strip() if len(parts) > 7 and parts[7].strip() else None
    email = parts[8].strip() if len(parts) > 8 and parts[8].strip() else None
    location_type = parts[9].strip() if len(parts) > 9 else 'Branch Bank'
    # State is in column 10 (index 10), but might be empty - check for "Texas" or "TX" in any column
    state = parts[10].strip() if len(parts) > 10 and parts[10].strip() else None
    if not state:
        # Look for state in any column
        for part in parts:
            if part.strip().upper() in ['TEXAS', 'TX', 'OKLAHOMA', 'OK']:
                state = part.strip()
                break
    if not state:
        state = 'Texas'  # Default
    
    if not address or not branch_id:
        return None
    
    # Extract city from branch ID (e.g., "PB - WEIMAR #128" -> "Weimar")
    city_match = re.search(r'PB\s*-\s*([A-Z\s]+?)\s*#', branch_id, re.IGNORECASE)
    if city_match:
        city = city_match.group(1).strip().title()
    else:
        # Try to extract from branch name
        city_match = re.search(r'([A-Z][A-Z\s]+?)\s*#', branch_id, re.IGNORECASE)
        if city_match:
            city = city_match.group(1).strip().title()
        else:
            # Fallback: try to find city in address (look for common patterns)
            city = None
    
    # Normalize state
    if not state or state.strip() == '':
        state = 'TX'  # Default to Texas if not specified
    elif state.upper() in ['TEXAS', 'TX']:
        state = 'TX'
    elif state.upper() in ['OKLAHOMA', 'OK']:
        state = 'OK'
    
    # Parse address - split into line1 and line2 if Suite/Ste present
    address_line1 = address
    address_line2 = None
    
    suite_match = re.search(r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)', address, re.IGNORECASE)
    if suite_match:
        pos = suite_match.start()
        address_line1 = address[:pos].strip()
        suite_text = suite_match.group(0).strip()
        if suite_text.startswith('Ste '):
            address_line2 = 'Ste ' + suite_match.group(2)
        elif suite_text.startswith('Ste.'):
            address_line2 = 'Ste. ' + suite_match.group(2)
        elif suite_text.startswith('Ste'):
            address_line2 = 'Ste ' + suite_match.group(2)
        else:
            address_line2 = suite_text
    
    # Extract zip code from address if present
    zip_code = None
    zip_match = re.search(r'\b(\d{5})\b', address)
    if zip_match:
        zip_code = zip_match.group(1)
    
    # Format phone number
    if phone:
        # Clean up phone
        phone = re.sub(r'[^\d\-\(\)\s]', '', phone)
        if not re.match(r'^\(', phone):
            # Format as (XXX) XXX-XXXX if not already formatted
            digits = re.sub(r'\D', '', phone)
            if len(digits) == 10:
                phone = f"({digits[:3]}) {digits[3:6]}-{digits[6:]}"
            elif len(digits) == 11 and digits[0] == '1':
                phone = f"({digits[1:4]}) {digits[4:7]}-{digits[7:]}"
    
    # Determine branch type
    final_branch_name = 'Prosperity Bank'
    notes = None
    branch_suffix = ''
    
    if 'ATM' in branch_id.upper() or 'ATM' in branch_name.upper():
        final_branch_name = 'Prosperity Bank - ATM'
        notes = 'ATM Only'
        branch_suffix = 'atm'
    elif 'Drive Thru Only' in branch_id or 'Drive-Thru Only' in branch_id:
        final_branch_name = 'Prosperity Bank - Drive Thru Only'
        notes = 'Drive-Thru Only'
        branch_suffix = 'drive_thru'
    elif 'Lobby Only' in branch_id:
        final_branch_name = 'Prosperity Bank - Lobby Only'
        notes = 'Lobby Only'
        branch_suffix = 'lobby'
    elif 'Remote Location' in location_type:
        notes = 'Remote Location'
    elif contact_name:
        notes = f'Contact: {contact_name}'
        if email:
            notes += f' ({email})'
    
    # Generate ID
    if city:
        city_clean = city.lower().replace(' ', '_').replace("'", "").replace('.', '').replace('-', '_')
    else:
        city_clean = 'unknown'
    
    # Extract street word from address
    addr_words = address_line1.split()
    street_word = None
    for word in addr_words:
        word_clean = word.rstrip('.,')
        if word_clean.upper() in ['N', 'S', 'E', 'W', 'N.', 'S.', 'E.', 'W.', 'NORTH', 'SOUTH', 'EAST', 'WEST', 'NE', 'NW', 'SE', 'SW', 'US', 'HWY', 'HIGHWAY', 'FM', 'ST', 'STREET', 'AVE', 'AVENUE', 'BLVD', 'BOULEVARD', 'DR', 'DRIVE', 'RD', 'ROAD', 'PKWY', 'PARKWAY']:
            continue
        if word_clean and word_clean[0].isalpha() and len(word_clean) > 1:
            street_word = word_clean.lower()
            break
    
    parts = []
    if street_word:
        parts.append(street_word)
    parts.append(city_clean)
    if branch_suffix:
        parts.append(branch_suffix)
    
    location_id = 'prosperity_' + '_'.join(parts)
    
    return {
        'id': location_id,
        'branchName': final_branch_name,
        'addressLine1': address_line1,
        'addressLine2': address_line2,
        'city': city or 'Unknown',
        'state': state,
        'zip': zip_code,
        'phone': phone,
        'operatingHours': None,  # Not in this format
        'notes': notes,
    }

def parse_all(text: str) -> List[Dict]:
    """Parse all locations from text."""
    locations = []
    seen = set()
    
    for line in text.split('\n'):
        line = line.strip()
        if not line or line.startswith('BANK'):
            continue
        
        loc = parse_line(line)
        if loc:
            # Deduplicate
            key = (loc['addressLine1'], loc.get('addressLine2'), loc['city'], loc['state'])
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
        if loc.get('zip'):
            lines.append(f"        zip: '{loc['zip']}',")
        else:
            lines.append(f"        zip: '',")
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
    
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            text = f.read()
    else:
        text = sys.stdin.read()
    
    locations = parse_all(text)
    print(f"# Parsed {len(locations)} locations", file=sys.stderr)
    print(generate_dart(locations))
