#!/usr/bin/env python3
"""
Simple parser - use known cities and states to separate fields easily.
"""

import re
from typing import Dict, List, Optional, Set

# Known cities - these are what we're looking for
KNOWN_CITIES: Set[str] = {
    'Mathis', 'Alice', 'Corpus Christi', 'Sinton', 'Beeville', 'Kingsville', 'Taft',
    'Portland', 'Aransas Pass', 'Rockport', 'Goliad', 'Pleasanton', 'Yorktown',
    'Kingsland', 'Cuero', 'Austin', 'Cedar Park', 'Yoakum', 'Bastrop', 'Flatonia',
    'Liberty Hill', 'Round Rock', 'Smithville', 'Elgin', 'Georgetown', 'Hallettsville',
    'Victoria', 'Schulenburg', 'La Grange', 'Weimar', 'Thorndale', 'Lexington',
    'Edna', 'Port Lavaca', 'Caldwell', 'El Campo', 'Wharton', 'Palacios', 'East Bernard',
    'Brownwood', 'Hearne', 'Early', 'College Station', 'Hempstead', 'Bryan', 'Bay City',
    'Navasota', 'Comanche', 'Needville', 'Waller', 'Katy', 'San Angelo', 'Hitchcock',
    'Cleveland', 'Merkel', 'Corsicana', 'Mont Belvieu', 'Dayton', 'Waxahachie', 'Crockett',
    'Galveston', 'Ennis', 'Weatherford', 'Kerens', 'Liberty', 'Grapeland', 'Fort Worth',
    'Red Oak', 'Cedar Hill', 'Arlington', 'Palestine', 'Haltom City', 'Seven Points',
    'Azle', 'Grand Prairie', 'Dallas', 'Gun Barrel City', 'Big Spring', 'Athens',
    'Eustace', 'Keller', 'Balch Springs', 'Grapevine', 'Roanoke', 'Snyder', 'Runaway Bay',
    'Mesquite', 'Jacksboro', 'Coppell', 'Rusk', 'Jacksonville', 'Midland', 'Carrollton',
    'Garland', 'Richardson', 'Plano', 'The Colony', 'Odessa', 'Beaumont', 'Frisco',
    'Wylie', 'Murphy', 'Allen', 'Tyler', 'Nederland', 'McKinney', 'Sanger', 'Groves',
    'Muenster', 'Gainesville', 'Henrietta', 'Wichita Falls', 'Winnsboro', 'Longview',
    'Gilmer', 'Carthage', 'Byers', 'Burkburnett', 'Slaton', 'Mount Vernon', 'Brownfield',
    'Lubbock', 'Floydada', 'Levelland', 'Plainview', 'Littlefield', 'Norman', 'Oklahoma City',
    'Edmond', 'Amarillo', 'Tulsa', 'Owasso', 'Houston', 'Rosenberg', 'Richmond', 'Cypress',
    'Magnolia', 'Sugar Land', 'Tomball', 'Missouri City', 'Webster', 'Granbury', 'Abilene',
    'Blooming Grove', 'West Columbia', 'South Houston', 'Gorman', 'Spring',
    'Madisonville', 'Angleton', 'Pearland', 'The Woodlands', 'Glen Rose', 'New Waverly',
    'Huntsville', 'Teague', 'Dime Box', 'San Antonio', 'New Braunfels'
}

STATES = {'TX', 'OK'}

def parse_entry(entry: str) -> Optional[Dict]:
    """Parse a single location entry using known separators."""
    entry = entry.strip()
    if not entry:
        return None
    
    # Step 1: Find state and zip (always together: ", TX 12345" or ", OK 12345")
    state_zip_match = re.search(r',\s+(TX|OK)\s+(\d{5})', entry)
    if not state_zip_match:
        return None
    
    state = state_zip_match.group(1)
    zip_code = state_zip_match.group(2)
    comma_pos = state_zip_match.start()
    
    # Step 2: Find city - search for "City, TX" or "City, OK" pattern
    city = None
    city_end_pos = comma_pos
    
    # Check known cities (longest first to match "Corpus Christi" before "Corpus")
    for known_city in sorted(KNOWN_CITIES, key=len, reverse=True):
        # Find city followed by comma and state
        pattern = r'\b' + re.escape(known_city) + r'\s*,\s+' + re.escape(state)
        match = re.search(pattern, entry, re.IGNORECASE)
        if match:
            city = known_city
            city_end_pos = match.start()  # Start of city (where address ends)
            break
    
    if not city:
        # Fallback: extract any capitalized word(s) before ", TX" or ", OK"
        city_match = re.search(r'([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?)\s*,\s+' + re.escape(state), entry)
        if city_match:
            city = city_match.group(1).strip()
            city_end_pos = city_match.start()
        else:
            return None
    
    # Step 3: Extract address - everything before the city
    address_text = entry[:city_end_pos].strip()
    
    # Remove entry number
    address_text = re.sub(r'^\d+\s+', '', address_text)
    
    # Remove "Prosperity Bank" variants
    address_text = re.sub(r'Prosperity Bank\s*-?\s*(ATM|Drive[\s-]?Thru Only|Lobby Only)?\s*', '', address_text, flags=re.IGNORECASE)
    
    # Remove distance
    address_text = re.sub(r'\d+\.\d+\s+mi\s+', '', address_text)
    
    # Clean up
    address_text = re.sub(r'\s+', ' ', address_text).strip()
    
    # Step 4: Extract phone
    phone = None
    phone_match = re.search(r'\((\d{3}|800)\)\s+(\d{3}[- ]?\d{4})', entry)
    if phone_match:
        area = phone_match.group(1)
        num = phone_match.group(2).replace(' ', '')
        if '-' not in num and len(num) == 7:
            num = f"{num[:3]}-{num[3:]}"
        phone = f"({area}) {num}"
    
    # Step 5: Extract operating hours (after zip code)
    after_zip = entry[state_zip_match.end():].strip()
    if phone:
        after_zip = after_zip.replace(phone, '', 1).strip()
    after_zip = re.sub(r'\([0-9]{3}\)\s+[0-9]{3}[- ]?[0-9]{4}', '', after_zip).strip()
    
    operating_hours = None
    if after_zip and (after_zip.startswith('Lobby:') or after_zip.startswith('Drive') or 
                      'Open' in after_zip or 'Closed' in after_zip):
        operating_hours = after_zip.replace(' · ', '\\n')
        # Remove "Call Now Get Directions" if present
        operating_hours = re.sub(r'\s*Call Now Get Directions.*$', '', operating_hours, flags=re.IGNORECASE).strip()
    
    # Step 6: Check branch type
    branch_name = 'Prosperity Bank'
    notes = None
    branch_suffix = ''
    
    if 'Prosperity Bank - ATM' in entry:
        branch_name = 'Prosperity Bank - ATM'
        notes = 'ATM Only'
        branch_suffix = 'atm'
    elif 'Drive Thru Only' in entry or 'Drive-Thru Only' in entry:
        branch_name = 'Prosperity Bank - Drive Thru Only'
        notes = 'Drive-Thru Only'
        branch_suffix = 'drive_thru'
    elif 'Lobby Only' in entry:
        branch_name = 'Prosperity Bank - Lobby Only'
        notes = 'Lobby Only'
        branch_suffix = 'lobby'
    
    # Step 7: Split Suite/Ste
    address_line1 = address_text
    address_line2 = None
    
    suite_match = re.search(r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)', address_text, re.IGNORECASE)
    if suite_match:
        pos = suite_match.start()
        address_line1 = address_text[:pos].strip()
        suite_text = suite_match.group(0).strip()
        if suite_text.startswith('Ste '):
            address_line2 = 'Ste ' + suite_match.group(2)
        elif suite_text.startswith('Ste.'):
            address_line2 = 'Ste. ' + suite_match.group(2)
        elif suite_text.startswith('Ste'):
            address_line2 = 'Ste ' + suite_match.group(2)
        else:
            address_line2 = suite_text
    
    # Step 8: Generate ID
    addr_words = address_line1.split()
    street_word = None
    for word in addr_words:
        word_clean = word.rstrip('.,')
        if word_clean.upper() in ['N', 'S', 'E', 'W', 'N.', 'S.', 'E.', 'W.', 'NORTH', 'SOUTH', 'EAST', 'WEST', 'NE', 'NW', 'SE', 'SW']:
            continue
        if word_clean and word_clean[0].isalpha() and len(word_clean) > 1:
            street_word = word_clean.lower()
            break
    
    parts = []
    if street_word:
        parts.append(street_word)
    city_clean = city.lower().replace(' ', '_').replace("'", "").replace('.', '')
    parts.append(city_clean)
    if branch_suffix:
        parts.append(branch_suffix)
    
    location_id = 'prosperity_' + '_'.join(parts)
    
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
    
    # Split by entries
    matches = list(re.finditer(r'\d+\s+Prosperity Bank', text))
    
    for i, match in enumerate(matches):
        start = match.start()
        if i + 1 < len(matches):
            end = matches[i + 1].start()
        else:
            end = len(text)
        
        entry = text[start:end].strip()
        loc = parse_entry(entry)
        
        if loc:
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
    
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            text = f.read()
    else:
        text = sys.stdin.read()
    
    locations = parse_all(text)
    print(f"# Parsed {len(locations)} locations", file=sys.stderr)
    print(generate_dart(locations))
