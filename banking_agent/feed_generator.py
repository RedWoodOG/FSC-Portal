from typing import List
from datetime import datetime
from jinja2 import Template

TEMPLATE = """
<!DOCTYPE html>
<html>
<head>
    <title>Banking Equipment News Feed</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; background: #f5f5f5; }
        .header { background: #2c3e50; color: white; padding: 20px; border-radius: 8px 8px 0 0; }
        .item { background: white; padding: 20px; margin: 15px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); border-left: 5px solid #3498db; }
        .meta { color: #666; font-size: 0.9em; margin-bottom: 10px; }
        .tag { background: #eee; padding: 2px 8px; border-radius: 4px; font-weight: bold; }
        .title { margin: 0 0 10px 0; font-size: 1.2em; }
        .title a { color: #2c3e50; text-decoration: none; }
        .desc { color: #444; line-height: 1.5; }
        .footer { text-align: center; color: #888; margin-top: 40px; font-size: 0.8em; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Banking Equipment Feed</h1>
        <p>Tracking: Bavis, Cassida, Medeco, American Vault, Fenco</p>
    </div>

    {% for item in items|sort(attribute='found_at', reverse=True) %}
    <div class="item">
        <div class="meta">
            <span class="tag">{{ item.source }}</span> • {{ item.category }}
        </div>
        <h2 class="title"><a href="{{ item.url }}" target="_blank">{{ item.title }}</a></h2>
        <div class="desc">{{ item.description }}</div>
    </div>
    {% endfor %}

    <div class="footer">
        Generated at {{ now }}
    </div>
</body>
</html>
"""

class FeedGenerator:
    def generate(self, items: List[dict], output_path: str = "feed.html"):
        template = Template(TEMPLATE)
        html = template.render(items=items, now=datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(html)
