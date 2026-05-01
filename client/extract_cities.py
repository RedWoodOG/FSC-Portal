#!/usr/bin/env python3
"""Extract all unique cities from the prosperity data."""

import re
import sys

def extract_cities(text: str) -> set:
    """Extract all cities from the text."""
    cities = set()
    
    # Find all city, state, zip patterns
    pattern = r'([A-Z][a-z]+(?:\s+[A-Z][a-z]+){0,2}),\s+([A-Z]{2})\s+(\d{5})'
    
    for match in re.finditer(pattern, text):
        city = match.group(1).strip()
        # Try to clean up - if city contains common street words, it's probably wrong
        # But for now, just collect all
        cities.add(city)
    
    return cities

if __name__ == '__main__':
    if len(sys.argv) > 1:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            text = f.read()
    else:
        text = sys.stdin.read()
    
    cities = sorted(extract_cities(text))
    print("CITIES = {")
    for city in cities:
        print(f"    '{city}',")
    print("}")
