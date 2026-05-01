#!/usr/bin/env python3
"""
Smart parser for Prosperity Bank locations - removes known elements to extract addresses.
"""

import re
from typing import Dict, List, Optional, Set

# Known cities from Texas and Oklahoma
KNOWN_CITIES: Set[str] = {
    'Mathis', 'Alice', 'Corpus Christi', 'Sinton', 'Beeville', 'Kingsville', 'Taft', 'Sinton',
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
    'Blooming Grove', 'Hitchcock', 'West Columbia', 'South Houston', 'Gorman', 'Spring',
    'Madisonville', 'Angleton', 'Pearland', 'The Woodlands', 'Glen Rose', 'New Waverly',
    'Huntsville', 'Teague', 'Dime Box'
}

def extract_address_by_removal(entry: str) -> Optional[str]:
    """Extract address by removing known elements."""
    # Start with the entry
    text = entry.strip()
    
    # Remove entry number at start
    text = re.sub(r'^\d+\s+', '', text)
    
    # Remove "Prosperity Bank" variants
    text = re.sub(r'Prosperity Bank\s*-?\s*(ATM|Drive[\s-]?Thru Only|Lobby Only)?\s*', '', text, flags=re.IGNORECASE)
    
    # Remove distance (X.X mi)
    text = re.sub(r'\d+\.\d+\s+mi\s+', '', text)
    
    # Remove zip codes (5-digit numbers)
    text = re.sub(r'\s+\d{5}\s+', ' ', text)
    
    # Remove states (TX, OK)
    text = re.sub(r'\s+(TX|OK)\s+', ' ', text)
    
    # Remove cities - need to be careful with order (longer names first)
    sorted_cities = sorted(KNOWN_CITIES, key=len, reverse=True)
    for city in sorted_cities:
        # Match city as whole word, case-insensitive
        pattern = r'\b' + re.escape(city) + r'\b'
        text = re.sub(pattern, '', text, flags=re.IGNORECASE)
    
    # Remove phone numbers
    text = re.sub(r'\([0-9]{3}\)\s+[0-9]{3}[- ]?[0-9]{4}', '', text)
    text = re.sub(r'\(800\)\s+531-1401', '', text)
    
    # Remove operating hours (everything from "Lobby:" or "Drive" onwards)
    text = re.sub(r'\s+Lobby:.*$', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\s+Drive.*$', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\s+Open.*$', '', text, flags=re.IGNORECASE)
    text = re.sub(r'\s+Closed.*$', '', text, flags=re.IGNORECASE)
    
    # Remove "Call Now Get Directions"
    text = re.sub(r'\s*Call Now Get Directions\s*', '', text, flags=re.IGNORECASE)
    
    # Clean up extra spaces
    text = re.sub(r'\s+', ' ', text).strip()
    
    # Remove trailing commas
    text = text.rstrip(',').strip()
    
    return text if text else None

def parse_entry(entry: str) -> Optional[Dict]:
    """Parse a single location entry."""
    entry = entry.strip()
    if not entry or len(entry) < 20:
        return None
    
    # Find state and zip first
    state_zip_match = re.search(r',\s+([A-Z]{2})\s+(\d{5})', entry)
    if not state_zip_match:
        return None
    
    state = state_zip_match.group(1)
    zip_code = state_zip_match.group(2)
    zip_pos = state_zip_match.start()
    
    # Find which known city appears just before ", ST ZIP"
    # Look at text before the comma
    before_comma = entry[:zip_pos].strip()
    
    # Find the last occurrence of any known city (check longer cities first)
    city = None
    for known_city in sorted(KNOWN_CITIES, key=len, reverse=True):
        # Find the city in the text (case-insensitive)
        pattern = r'\b' + re.escape(known_city) + r'\b'
        match = re.search(pattern, before_comma, re.IGNORECASE)
        if match:
            # Check if it's followed by comma and state
            after_match = before_comma[match.end():].strip()
            if after_match.startswith(',') or (after_match == '' and entry[zip_pos:zip_pos+1] == ','):
                city = known_city
                break
    
    # Fallback: if no known city found, use regex to extract
    if not city:
        city_match = re.search(r'([A-Z][a-z]+(?:\s+[A-Z][a-z]+)?),\s+' + re.escape(state) + r'\s+' + re.escape(zip_code), entry)
        if city_match:
            city = city_match.group(1).strip()
        else:
            return None
    
    # Extract phone
    phone = None
    phone_match = re.search(r'\((\d{3}|800)\)\s+(\d{3}[- ]?\d{4})', entry)
    if phone_match:
        area = phone_match.group(1)
        num = phone_match.group(2).replace(' ', '')
        if '-' not in num and len(num) == 7:
            num = f"{num[:3]}-{num[3:]}"
        phone = f"({area}) {num}"
    
    # Extract address using removal method
    address_part = extract_address_by_removal(entry)
    if not address_part:
        return None
    
    # Check branch type
    branch_name = 'Prosperity Bank'
    notes = None
    branch_suffix = ''
    
    if 'Prosperity Bank - ATM' in entry or 'ATM' in entry and 'Prosperity Bank' in entry:
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
    
    # Split Suite/Ste from address
    address_line1 = address_part
    address_line2 = None
    
    suite_match = re.search(r'\s+(Suite|Ste\.?|#)\s*([A-Za-z0-9#]+)', address_part, re.IGNORECASE)
    if suite_match:
        pos = suite_match.start()
        address_line1 = address_part[:pos].strip()
        suite_text = suite_match.group(0).strip()
        if suite_text.startswith('Ste '):
            address_line2 = 'Ste ' + suite_match.group(2)
        elif suite_text.startswith('Ste.'):
            address_line2 = 'Ste. ' + suite_match.group(2)
        elif suite_text.startswith('Ste'):
            address_line2 = 'Ste ' + suite_match.group(2)
        else:
            address_line2 = suite_text
    
    # Extract operating hours - everything after the zip code
    after_city = entry[state_zip_match.end():].strip()
    if phone:
        after_city = after_city.replace(phone, '', 1).strip()
    after_city = re.sub(r'\([0-9]{3}\)\s+[0-9]{3}[- ]?[0-9]{4}', '', after_city).strip()
    
    operating_hours = None
    if after_city and (after_city.startswith('Lobby:') or after_city.startswith('Drive') or 
                      'Open' in after_city or 'Closed' in after_city):
        operating_hours = after_city
        operating_hours = operating_hours.replace(' · ', '\\n')
    
    # Generate ID
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
    """Parse all locations from text."""
    locations = []
    seen = set()
    
    # Split by entries - look for pattern: number + "Prosperity Bank"
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
    
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            text = f.read()
    else:
        text = sys.stdin.read()
    
    locations = parse_all(text)
    print(f"# Parsed {len(locations)} locations", file=sys.stderr)
    print(generate_dart(locations))
