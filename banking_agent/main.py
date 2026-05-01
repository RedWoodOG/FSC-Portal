import json
import logging
from datetime import datetime
from scrapers import BavisScraper, CassidaScraper, MedecoScraper, AmericanVaultScraper, FencoScraper
from database.storage import Storage
from feed_generator import FeedGenerator

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def get_scraper_class(name):
    return globals()[name]

def main():
    logger.info("Starting Banking Agent Monitor...")
    
    # Load Config
    with open('config.json', 'r') as f:
        config = json.load(f)
    
    storage = Storage()
    
    total_new = 0
    all_scraped_items = []

    for site in config['sites']:
        logger.info(f"Checking {site['name']}...")
        try:
            scraper_cls = get_scraper_class(site['scraper'])
            scraper = scraper_cls(site['name'], site['url'], site['category'])
            items = scraper.scrape()
            
            new_count = storage.add_items(items)
            total_new += new_count
            logger.info(f"Found {len(items)} items ({new_count} new) from {site['name']}")
            
        except Exception as e:
            import traceback
            traceback.print_exc()
            logger.error(f"Failed to scrape {site['name']}: {e}")

    # Regenerate Feed
    items = storage.get_all_items()
    
    feed_gen = FeedGenerator()
    feed_gen.generate(items)
    
    # Portal Integration
    from exporters import JsonExporter, RssExporter
    JsonExporter().export(items)
    RssExporter().export(items)
    
    logger.info(f"Cycle complete. Total new items: {total_new}")

if __name__ == "__main__":
    main()
