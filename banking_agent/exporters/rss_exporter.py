import datetime
from typing import List
try:
    import lxml.etree as ET
except ImportError:
    import xml.etree.ElementTree as ET

class RssExporter:
    def export(self, items: list, output_path: str = "feed.xml"):
        """Exports items to RSS 2.0 format."""
        
        rss = ET.Element("rss", version="2.0")
        channel = ET.SubElement(rss, "channel")
        
        ET.SubElement(channel, "title").text = "Banking Equipment News Feed"
        ET.SubElement(channel, "link").text = "http://localhost"
        ET.SubElement(channel, "description").text = "Monitoring American Banking Equipment Manufacturers"
        ET.SubElement(channel, "lastBuildDate").text = datetime.datetime.utcnow().strftime("%a, %d %b %Y %H:%M:%S GMT")
        
        # Sort items by date
        sorted_items = sorted(items, key=lambda x: x.get('found_at', ''), reverse=True)
        
        for item in sorted_items:
            item_node = ET.SubElement(channel, "item")
            ET.SubElement(item_node, "title").text = item.get('title')
            ET.SubElement(item_node, "link").text = item.get('url')
            ET.SubElement(item_node, "description").text = item.get('description')
            ET.SubElement(item_node, "category").text = item.get('category')
            ET.SubElement(item_node, "source").text = item.get('source')
            
            # PubDate
            # Handle timestamps or strings
            date_val = item.get('date')
            dt_obj = datetime.datetime.now()
            if isinstance(date_val, (int, float)):
                dt_obj = datetime.datetime.fromtimestamp(date_val)
            elif isinstance(date_val, str):
                 try:
                    dt_obj = datetime.datetime.fromisoformat(date_val)
                 except:
                    pass
            
            ET.SubElement(item_node, "pubDate").text = dt_obj.strftime("%a, %d %b %Y %H:%M:%S GMT")

        tree = ET.ElementTree(rss)
        tree.write(output_path, encoding="utf-8", xml_declaration=True)
