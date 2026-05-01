import requests
from bs4 import BeautifulSoup

url = "https://fencobankequipment.com/products"
from datetime import datetime
print(f"Datetime test: {datetime.now()}")
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'}
try:
    resp = requests.get(url, headers=headers, timeout=10)
    print(f"Status: {resp.status_code}")
    print(f"Length: {len(resp.text)}")
    soup = BeautifulSoup(resp.text, 'lxml')
    products = soup.select('.product, .product-item, .grid-item')
    print(f"Products found with select: {len(products)}")
    
    # Dump some classes to see what's there
    divs = soup.find_all('div', class_=True)
    classes = set()
    for d in divs:
        classes.update(d['class'])
    print(f"Classes seen: {list(classes)[:20]}")
    
except Exception as e:
    print(f"Error: {e}")
