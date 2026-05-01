import requests
from bs4 import BeautifulSoup
import time
from typing import List, Optional
from .base_scraper import BaseScraper, ScrapedItem
import logging

# Setup basic logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class SimpleBs4Scraper(BaseScraper):
    """Refactored common logic for static sites."""
    def fetch_soup(self, url: str) -> Optional[BeautifulSoup]:
        try:
            print(f"DEBUG: Fetching {url}")
            headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'}
            response = requests.get(url, headers=headers, timeout=15)
            response.raise_for_status()
            return BeautifulSoup(response.content, 'lxml')
        except Exception as e:
            logger.error(f"Error fetching {self.name} at {url}: {e}")
            return None

class BavisScraper(SimpleBs4Scraper):
    def scrape(self) -> List[ScrapedItem]:
        items = []
        soup = self.fetch_soup(self.base_url)
        if not soup: return items
        
        main_content = soup.find('main') or soup.find('div', class_='content') or soup.body
        links = main_content.find_all('a', href=True)
        
        seen = set()
        for link in links:
            text = link.get_text(strip=True)
            href = link.get('href')
            
            if len(text) < 5: continue
            if "read more" in text.lower(): continue
            if href in seen: continue
            
            seen.add(href)
            if not href.startswith('http'): href = f"https://blog.bavis.com{href}"
            
            items.append(ScrapedItem(
                title=text,
                url=href,
                date=time.time(), # Raw timestamp, handle in storage/feed
                description="Bavis Item",
                image_url=None,
                source=self.name,
                category=self.category
            ))
            if len(items) >= 5: break
        return items

class CassidaScraper(SimpleBs4Scraper):
    def scrape(self) -> List[ScrapedItem]:
        items = []
        soup = self.fetch_soup(self.base_url)
        if not soup: return items
        
        links = soup.find_all('a', href=True)
        seen = set()
        for link in links:
            href = link.get('href')
            text = link.get_text(strip=True)
            
            if "blogs/news" not in href and len(text) < 5: continue
            if href in seen: continue
            seen.add(href)
            
            if not href.startswith('http'): href = f"https://www.cassidausa.com{href}"
            
            items.append(ScrapedItem(
                title=text,
                url=href,
                date=time.time(),
                description="Cassida Item",
                image_url=None,
                source=self.name,
                category=self.category
            ))
            if len(items) >= 5: break
        return items

class MedecoScraper(SimpleBs4Scraper):
    def scrape(self) -> List[ScrapedItem]:
        items = []
        soup = self.fetch_soup(self.base_url)
        if not soup: return items
        
        links = soup.find_all('a', href=True)
        seen = set()
        for link in links:
            href = link.get('href')
            text = link.get_text(strip=True)
            
            if 'resources/blog' not in href or len(text) < 10: continue
            if href in seen: continue
            seen.add(href)
            
            if not href.startswith('http'): href = f"https://www.medeco.com{href}"
            
            items.append(ScrapedItem(
                title=text,
                url=href,
                date=time.time(),
                description="Medeco Article",
                image_url=None,
                source=self.name,
                category=self.category
            ))
            if len(items) >= 5: break
        return items

class AmericanVaultScraper(SimpleBs4Scraper):
    def scrape(self) -> List[ScrapedItem]:
        items = []
        soup = self.fetch_soup(self.base_url)
        if not soup: return items
        
        links = soup.find_all('a', href=True)
        seen = set()
        keywords = ["Vault", "Safe", "Door", "Locker", "Drawer", "Equipment"]
        
        for link in links:
            text = link.get_text(strip=True)
            href = link.get('href')
            
            if not any(k in text for k in keywords): continue
            if href in seen: continue
            seen.add(href)
            
            if not href.startswith('http'): href = f"https://americanvault.us/{href.lstrip('/')}"
            
            items.append(ScrapedItem(
                title=f"Product: {text}",
                url=href,
                date=time.time(),
                description="American Vault Product",
                image_url=None,
                source=self.name,
                category=self.category
            ))
            if len(items) >= 10: break
        return items

class FencoScraper(SimpleBs4Scraper):
    def scrape(self) -> List[ScrapedItem]:
        items = []
        soup = self.fetch_soup(self.base_url)
        if not soup: return items
        
        links = soup.body.find_all('a', href=True)
        seen = set()
        
        for link in links:
            text = link.get_text(strip=True)
            href = link.get('href')
            
            if "/product/" not in href or len(text) < 5: continue
            if href in seen: continue
            seen.add(href)
            
            if not href.startswith('http'): href = f"https://fencobankequipment.com{href}"
            
            items.append(ScrapedItem(
                title=text,
                url=href,
                date=time.time(),
                description="Fenco Product",
                image_url=None,
                source=self.name,
                category=self.category
            ))
            if len(items) >= 8: break
        return items
