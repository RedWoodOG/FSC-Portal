#!/usr/bin/env python3
"""De-identify the product seed: real clients, staff and residences -> synthetic demo data."""
import re, sys, pathlib

root = pathlib.Path(sys.argv[1])
seed = root / "lib/database/seed_service.dart"
src = seed.read_text(encoding="utf-8")
orig_len = len(src)

# --- 1. Drop the customer-specific location enrichment entirely -------------
start = src.index("Future<void> _seedProsperityLocations(AppDatabase db) async {")
end = src.index("Future<void> _seedTeamMembers(AppDatabase db) async {")
src = src[:start] + src[end:]
src = src.replace("    await _seedProsperityLocations(db);\n", "")
src = src.replace(
    "    // But we still check for Prosperity enrichment, team updates, and knowledge",
    "    // Deployment fixtures may still add client sites; team + knowledge always run.",
)

# --- 2. Synthetic team roster ----------------------------------------------
roster_start = src.index("  final teamMembers = [")
roster_end = src.index("  ];", roster_start) + len("  ];")
demo_roster = ["  final teamMembers = ["]
for i in range(1, 9):
    demo_roster += [
        "    {",
        f"      'username': 'tech{i}',",
        f"      'fullName': 'Demo Technician {i}',",
        f"      'email': 'tech{i}@example.com',",
        "    },",
    ]
demo_roster.append("  ];")
src = src[:roster_start] + "\n".join(demo_roster) + src[roster_end:]

usernames = ["aosmer", "jbennett", "cmitchel", "cvanderpool",
             "etarvin", "jwacker", "oidrizi", "rdutton"]
old_list = "  final teamMemberUsernames = [\n" + "".join(f"    '{u}',\n" for u in usernames) + "  ];"
new_list = "  final teamMemberUsernames = [\n" + "".join(f"    'tech{i}',\n" for i in range(1, 9)) + "  ];"
assert old_list in src, "team username list shape changed"
src = src.replace(old_list, new_list)
src = src.replace("u.username == 'jbennet' || u.username == 'Chand'",
                  "u.username == 'legacy_demo'")
src = src.replace("user.username.toLowerCase() == 'jbennet' ||\n        user.username.toLowerCase() == 'cmitchel'",
                  "user.username.toLowerCase() == 'legacy_demo'")

# --- 3. Identifying strings -------------------------------------------------
subs = [
    # clients
    ("'RBFCU'", "'Northwind Credit Union'"),
    ("'Jefferson Bank'", "'Lone Star Bank'"),
    ("'Prosperity Bank'", "'Gulf Coast Bank'"),
    ("RBFCU - Bulverde", "Northwind - Demo Route"),
    ("// Insert Sites - RBFCU", "// Insert Sites - Northwind Credit Union"),
    ("// Insert Sites - Jefferson Bank", "// Insert Sites - Lone Star Bank"),
    ("// Insert Sites - Prosperity Bank", "// Insert Sites - Gulf Coast Bank"),
    ("- 3 Clients (RBFCU, Jefferson Bank, Prosperity Bank)",
     "- 3 demo clients"),
    # operator identity
    ("'jwhite'", "'demotech'"),
    ("'Joseph White'", "'Demo Technician'"),
    ("'Joseph.white@fincialsystemscorp.com'", "'demotech@example.com'"),
    ("// Delete existing team members (by username) - keeps Joseph White and other users",
     "// Delete existing team members (by username) - keeps the primary demo user"),
    # residences: names + the address comments + the real coordinates
    ('name: "Joseph\'s House",', "name: 'Home Base',"),
    ("latitude: 29.4188531, // 1731 Aspen Silver, San Antonio TX 78245",
     "latitude: 29.4241,"),
    ("longitude: -98.6832171,", "longitude: -98.4936,"),
    ("name:\n                'Office', // Shop: 8816 Tradeway, San Antonio TX 78217 Suite 116",
     "name: 'Service Shop',"),
    ("latitude: 29.5206537,", "latitude: 29.5150,"),
    ("longitude: -98.4582949,", "longitude: -98.4600,"),
    ('name: "Aaron\'s House",', "name: 'Home Base 2',"),
]
for old, new in subs:
    if old not in src:
        print(f"  WARN not found: {old[:60]!r}")
    src = src.replace(old, new)

seed.write_text(src, encoding="utf-8")
print(f"seed_service.dart: {orig_len} -> {len(src)} bytes")
