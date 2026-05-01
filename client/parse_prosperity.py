#!/usr/bin/env python3
"""
Parse Prosperity Bank locations from text and generate Dart code
"""

import re
from collections import OrderedDict

# Read the full input text (this would be from the user's message)
# For now, I'll create a parser that can handle the format

def parse_location_blocks(text):
    """Parse location blocks from the text format"""
    locations = OrderedDict()
    
    # Pattern to match location blocks
    # Format: Number BranchName Distance Address City, State ZIP Phone Hours...
    pattern = r'(\d+)\s+(Prosperity Bank(?: - (?:ATM|Drive Thru Only|Lobby Only))?)\s+[\d.]+ mi\s+(.+?)\s+([A-Za-z\s]+),\s+([A-Z]{2})\s+(\d{5})\s+(\([^)]+\))?\s*(.*?)(?:Call Now|$)'
    
    # Split by "Call Now Get Directions" or similar markers
    blocks = re.split(r'\s+Call Now\s+Get Directions\s+', text)
    
    for block in blocks:
        if not block.strip():
            continue
            
        # Extract number
        num_match = re.match(r'^(\d+)\s+', block)
        if not num_match:
            continue
        num = num_match.group(1)
        
        # Extract branch name
        branch_match = re.search(r'Prosperity Bank(?: - (?:ATM|Drive Thru Only|Lobby Only))?', block)
        if not branch_match:
            continue
        branch_full = branch_match.group(0)
        branch_type = None
        if ' - ATM' in branch_full:
            branch_type = 'ATM'
            branch_name = 'Prosperity Bank - ATM'
        elif ' - Drive Thru Only' in branch_full:
            branch_type = 'Drive Thru Only'
            branch_name = 'Prosperity Bank - Drive Thru Only'
        elif ' - Lobby Only' in branch_full:
            branch_type = 'Lobby Only'
            branch_name = 'Prosperity Bank - Lobby Only'
        else:
            branch_name = 'Prosperity Bank'
        
        # Extract address (after branch name, before city)
        # Find the pattern: address ... City, State ZIP
        addr_city_match = re.search(r'Prosperity Bank[^-]*(?: - [^-]+)?\s+[\d.]+\s+mi\s+(.+?)\s+([A-Za-z\s]+),\s+([A-Z]{2})\s+(\d{5})', block)
        if not addr_city_match:
            continue
        
        address_part = addr_city_match.group(1).strip()
        city = addr_city_match.group(2).strip()
        state = addr_city_match.group(3)
        zip_code = addr_city_match.group(4)
        
        # Split address into line1 and line2 (handle Suite/Ste)
        address_line1 = address_part
        address_line2 = None
        suite_match = re.search(r'\s+(Suite|Ste|#)\s*([A-Za-z0-9]+)', address_part, re.IGNORECASE)
        if suite_match:
            suite_part = suite_match.group(0).strip()
            address_line1 = address_part[:suite_match.start()].strip()
            address_line2 = suite_part
        
        # Extract phone
        phone_match = re.search(r'\([0-9]{3}\)\s+[0-9]{3}-[0-9]{4}|\([0-9]{3}\)\s+[0-9]{3}-[0-9]{4}|\([0-9]{3}\)\s+[0-9]{7}', block)
        phone = phone_match.group(0) if phone_match else None
        
        # Extract operating hours (everything after phone until "Call Now" or end)
        hours_match = re.search(r'(?:Lobby|Drive-Thru):.*?(?=Call Now|$)', block, re.DOTALL)
        operating_hours = hours_match.group(0).strip() if hours_match else None
        
        # Create unique key
        key = f"{address_line1}|{city}|{state}|{zip_code}"
        
        # Only add if not duplicate
        if key not in locations:
            locations[key] = {
                'branch_name': branch_name,
                'branch_type': branch_type,
                'address_line1': address_line1,
                'address_line2': address_line2,
                'city': city,
                'state': state,
                'zip': zip_code,
                'phone': phone,
                'operating_hours': operating_hours,
            }
    
    return locations

def generate_id(city, address_line1, branch_type=None):
    """Generate a unique ID"""
    city_norm = city.lower().replace(' ', '_')
    
    # Extract key from address
    addr_lower = address_line1.lower()
    addr_key = None
    
    if 'northwest' in addr_lower:
        addr_key = 'northwest'
    elif 'northeast' in addr_lower:
        addr_key = 'northeast'
    elif 'southwest' in addr_lower:
        addr_key = 'southwest'
    elif 'southeast' in addr_lower:
        addr_key = 'southeast'
    elif 'north' in addr_lower and 'northwest' not in addr_lower:
        addr_key = 'north'
    elif 'south' in addr_lower and 'southwest' not in addr_lower:
        addr_key = 'south'
    elif 'east' in addr_lower:
        addr_key = 'east'
    elif 'west' in addr_lower:
        addr_key = 'west'
    else:
        # Extract first significant word
        words = addr_lower.replace('.', '').replace(',', '').split()
        skip_words = {'n', 's', 'e', 'w', 'north', 'south', 'east', 'west', 'highway', 'hwy', 'street', 'st', 'avenue', 'ave', 'road', 'rd', 'boulevard', 'blvd', 'parkway', 'pkwy'}
        for word in words:
            if word not in skip_words and not word.isdigit():
                addr_key = word
                break
    
    if not addr_key:
        addr_key = 'main'
    
    id_parts = ['prosperity', city_norm]
    if addr_key:
        id_parts.append(addr_key)
    if branch_type:
        id_parts.append(branch_type.lower().replace(' ', '_'))
    
    return '_'.join(id_parts)

print("Parser functions defined")
