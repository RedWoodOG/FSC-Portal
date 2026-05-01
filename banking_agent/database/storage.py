import json
import os
from typing import List, Dict
from scrapers.base_scraper import ScrapedItem
from datetime import datetime

class Storage:
    def __init__(self, db_path: str = "database/items.json"):
        self.db_path = db_path
        self.data: Dict[str, dict] = {}
        self.load()

    def load(self):
        if os.path.exists(self.db_path):
            with open(self.db_path, 'r') as f:
                self.data = json.load(f)

    def save(self):
        os.makedirs(os.path.dirname(self.db_path), exist_ok=True)
        with open(self.db_path, 'w') as f:
            json.dump(self.data, f, indent=2, default=str)

    def add_items(self, items: List[ScrapedItem]) -> int:
        new_count = 0
        for item in items:
            if item.url not in self.data:
                self.data[item.url] = {
                    "title": item.title,
                    "url": item.url,
                    "date": item.date,
                    "description": item.description,
                    "source": item.source,
                    "category": item.category,
                    "found_at": datetime.now()
                }
                new_count += 1
        if new_count > 0:
            self.save()
        return new_count
    
    def get_all_items(self) -> List[dict]:
        return list(self.data.values())
