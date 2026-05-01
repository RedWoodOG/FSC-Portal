#!/usr/bin/env python3
"""
Parse Prosperity Bank locations from text and generate Dart code.
"""

import re
from typing import Dict, List, Optional

def normalize_id(city: str, address: str, branch_type: str = "") -> str:
    """Generate a unique ID from city and address."""
    parts = []
    
    # Extract street name from address
    # Remove common prefixes and get the main street name
    address_clean = re.sub(r'^\d+\s+([NWSE]\s+)?', '', address)
    words = address_clean.split()
    if words:
        # Take first significant word (skip common words)
        street_word = words[0].lower()
        if street_word not in ['n', 's', 'e', 'w', 'north', 'south', 'east', 'west']:
            parts.append(street_word)
        elif len(words) > 1:
            parts.append(words[1].lower())
    
    # Add city
    city_clean = city.lower().replace(' ', '_').replace("'", "").replace('.', '')
    parts.append(city_clean)
    
    # Add branch type suffix if special
    if branch_type:
        type_clean = branch_type.lower().replace(' ', '_').replace('-', '_').replace('_only', '')
        if type_clean:
            parts.append(type_clean)
    
    # Handle duplicates by adding address detail
    id_base = 'prosperity_' + '_'.join(parts)
    return id_base

def parse_location(entry: str) -> Optional[Dict]:
    """Parse a single location entry."""
    entry = entry.strip()
    if not entry:
        return None
    
    # Remove "Call Now Get Directions"
    entry = re.sub(r'\s*Call Now Get Directions\s*', '', entry, flags=re.IGNORECASE)
    
    # Find city, state, zip pattern
    city_match = re.search(r'([A-Za-z][A-Za-z\s\.]+),\s+([A-Z]{2})\s+(\d{5})', entry)
    if not city_match:
        return None
    
    city = city_match.group(1).strip()
    state = city_match.group(2)
    zip_code = city_match.group(3)
    
    # Extract phone number
    phone_match = re.search(r'\((\d{3}|800)\)\s+(\d{3}[- ]?\d{4})', entry)
    phone = None
    if phone_match:
        phone = f"({phone_match.group(1)}) {phone_match.group(2)}"
        if '-' not in phone_match.group(2):
            # Format as XXX-XXXX
            digits = phone_match.group(2).replace(' ', '')
            if len(digits) == 7:
                phone = f"({phone_match.group(1)}) {digits[:3]}-{digits[3:]}"
    
    # Extract branch name and special type
    branch_name = 'Prosperity Bank'
    notes = None
    
    # Check for special branch types before address
    before_city = entry[:city_match.start()].strip()
    
    if 'Prosperity Bank - ATM' in before_city or 'Prosperity Bank ATM' in before_city:
        branch_name = 'Prosperity Bank - ATM'
        notes = 'ATM Only'
    elif 'Prosperity Bank - Drive Thru Only' in before_city or 'Prosperity Bank - Drive-Thru Only' in before_city:
        branch_name = 'Prosperity Bank - Drive Thru Only'
        notes = 'Drive-Thru Only'
    elif 'Prosperity Bank - Lobby Only' in before_city:
        branch_name = 'Prosperity Bank - Lobby Only'
        notes = 'Lobby Only'
    
    # Extract address (between branch name/distance and city)
    # Remove leading number
    before_city = re.sub(r'^\d+\s+', '', before_city)
    # Remove "Prosperity Bank" variants
    before_city = re.sub(r'Prosperity Bank\s*-?\s*(ATM|Drive[\s-]?Thru Only|Lobby Only)?\s*', '', before_city, flags=re.IGNORECASE)
    # Remove distance (X.X mi)
    before_city = re.sub(r'\d+\.\d+\s+mi\s+', '', before_city)
    address_part = before_city.strip()
    
    # Split address into line1 and line2 if Suite/Ste present
    address_line1 = address_part
    address_line2 = None
    
    suite_patterns = [
        r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)',
        r'\s+Ste\s*(\d+)',
    ]
    
    for pattern in suite_patterns:
        suite_match = re.search(pattern, address_part, re.IGNORECASE)
        if suite_match:
            suite_start = suite_match.start()
            address_line1 = address_part[:suite_start].strip()
            suite_text = suite_match.group(0).strip()
            # Normalize Suite format
            if suite_text.startswith('Ste '):
                address_line2 = 'Ste ' + suite_match.group(1) if len(suite_match.groups()) > 1 else suite_text
            elif suite_text.startswith('Ste.'):
                address_line2 = 'Ste. ' + suite_match.group(1) if len(suite_match.groups()) > 1 else suite_text
            else:
                address_line2 = suite_text
            break
    
    # Extract operating hours (after city/state/zip and phone)
    operating_hours = None
    after_city = entry[city_match.end():].strip()
    
    if phone:
        # Remove phone from after_city
        after_city = after_city.replace(phone, '', 1).strip()
    
    # Operating hours typically start with "Lobby:", "Drive-Thru:", or similar
    if after_city:
        # Clean up any remaining phone patterns
        after_city = re.sub(r'\([0-9]{3}\)\s+[0-9]{3}[- ]?[0-9]{4}', '', after_city)
        after_city = after_city.strip()
        
        if after_city and (after_city.startswith('Lobby:') or after_city.startswith('Drive') or 
                          'Open' in after_city or 'Closed' in after_city):
            operating_hours = after_city
            # Normalize newlines
            operating_hours = operating_hours.replace(' · ', ' ')
    
    # Generate ID
    branch_suffix = ''
    if 'ATM' in branch_name:
        branch_suffix = 'atm'
    elif 'Drive' in branch_name:
        branch_suffix = 'drive_thru'
    elif 'Lobby' in branch_name:
        branch_suffix = 'lobby'
    
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

def parse_all_locations(text: str) -> List[Dict]:
    """Parse all locations from the text block."""
    locations = []
    seen = set()
    
    # Split by entries that start with a number followed by "Prosperity Bank"
    # Use a more robust pattern
    pattern = r'(\d+)\s+(Prosperity Bank[^\d]*(?:\d+\.\d+\s+mi\s+)?[^,]+,\s+[A-Z]{2}\s+\d{5}[^0-9]*(?:\([0-9]{3}\)[^0-9]+)?[^0-9]*)'
    
    matches = list(re.finditer(pattern, text))
    
    for match in matches:
        entry_text = match.group(0)
        location = parse_location(entry_text)
        
        if location:
            # Deduplicate by address + city + state + zip
            key = (location['addressLine1'], location.get('addressLine2'), location['city'], location['state'], location['zip'])
            if key not in seen:
                seen.add(key)
                locations.append(location)
    
    return locations

def generate_dart_code(locations: List[Dict]) -> str:
    """Generate Dart code for all locations."""
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
            # Escape properly for Dart
            hours = loc['operatingHours'].replace("'", "\\'").replace('\n', '\\n')
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
    
    locations = parse_all_locations(text)
    print(f"# Parsed {len(locations)} unique locations", file=sys.stderr)
    print(generate_dart_code(locations))
