from abc import ABC, abstractmethod
from dataclasses import dataclass
from datetime import datetime
from typing import List, Optional

@dataclass
class ScrapedItem:
    title: str
    url: str
    date: Optional[datetime]
    description: str
    image_url: Optional[str]
    source: str
    category: str

class BaseScraper(ABC):
    def __init__(self, name: str, base_url: str, category: str):
        self.name = name
        self.base_url = base_url
        self.category = category

    @abstractmethod
    def scrape(self) -> List[ScrapedItem]:
        """Scrapes the target website and returns a list of items."""
        pass
