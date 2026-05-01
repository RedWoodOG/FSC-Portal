import json
import datetime
import time

class JsonExporter:
    def export(self, items: list, output_path: str = "feed.json"):
        """
        Exports items to a JSON file matching the IndustryBriefing schema.
        Schema:
        [
          {
            "title": "String",
            "source": "String",
            "previewImage": "String (optional)",
            "publishedAt": "ISO8601",
            "fetchedAt": "ISO8601" 
          }
        ]
        """
        export_data = []
        for item in items:
            # Handle date conversion
            # item['date'] might be float (timestamp) or str (from loaded json)
            published_at = item.get('date')
            if isinstance(published_at, (int, float)):
                published_at_dt = datetime.datetime.fromtimestamp(published_at)
            elif isinstance(published_at, str):
                try:
                    published_at_dt = datetime.datetime.fromisoformat(published_at)
                except ValueError:
                    published_at_dt = datetime.datetime.now() # Fallback
            else:
                 published_at_dt = datetime.datetime.now()

            # Handle fetched_at
            fetched_at = item.get('found_at')
            if isinstance(fetched_at, str):
                try:
                     fetched_at_dt = datetime.datetime.fromisoformat(fetched_at)
                except ValueError:
                     fetched_at_dt = datetime.datetime.now()
            elif isinstance(fetched_at, datetime.datetime):
                fetched_at_dt = fetched_at
            else:
                fetched_at_dt = datetime.datetime.now()

            export_data.append({
                "title": item.get('title', 'No Title'),
                "source": item.get('source', 'Unknown Source'),
                "previewImage": item.get('image_url'), # Maps to previewImage in DB
                "publishedAt": published_at_dt.isoformat(),
                "fetchedAt": fetched_at_dt.isoformat(),
                # Extra fields for completeness, though likely ignored by strict schema import
                "url": item.get('url'),
                "category": item.get('category')
            })
        
        # Sort by publishedAt desc
        export_data.sort(key=lambda x: x['publishedAt'], reverse=True)

        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(export_data, f, indent=2)
