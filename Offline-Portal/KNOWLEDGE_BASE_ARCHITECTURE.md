# Knowledge Base Architecture - Visual System Map

**Version:** 3.0.0  
**Last Updated:** January 31, 2026  
**Purpose:** Complete visual ASCII diagrams of the enhanced knowledge base system

---

## System Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                   FSC PORTAL KNOWLEDGE BASE v3.0                        │
│                    Enterprise Technical Documentation System            │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│  CONTENT LAYER   │    │   DATA LAYER     │    │    UI LAYER      │
│                  │    │                  │    │                  │
│ • Markdown files │    │ • SQLite DB      │    │ • Search UI      │
│ • YAML metadata  │    │ • 8 tables       │    │ • Category Nav   │
│ • Attachments    │    │ • FTS5 index     │    │ • Article View   │
│ • Staging dir    │    │ • Triggers       │    │ • Filters        │
└────────┬─────────┘    └────────┬─────────┘    └────────┬─────────┘
         │                       │                       │
         │  Import Process       │  Query/Update         │  Display
         └───────────────────────┴───────────────────────┘
```

---

## Data Flow Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          DATA FLOW DIAGRAM                              │
└─────────────────────────────────────────────────────────────────────────┘

CONTENT AUTHORING
┌──────────────────────────────────┐
│  Author Creates Article          │
│  (Markdown + YAML frontmatter)   │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  File Saved to Staging Directory │
│  C:\Portal_Knowledge_Staging\    │
└────────────────┬─────────────────┘
                 │
                 ▼
        ┌────────────────┐
        │  IMPORT ENGINE │
        └────────┬───────┘
                 │
                 ├─► Parse YAML frontmatter
                 ├─► Extract markdown body
                 ├─► Validate metadata
                 ├─► Generate defaults
                 ├─► Process arrays → JSON
                 └─► Detect create vs update
                 │
                 ▼
┌──────────────────────────────────┐
│  DATABASE INSERT/UPDATE          │
│  knowledge_entries table         │
└────────────────┬─────────────────┘
                 │
                 ├─► Trigger: FTS5 sync
                 ├─► Trigger: Create metadata record
                 └─► Trigger: Audit history log
                 │
                 ▼
┌──────────────────────────────────┐
│  FTS5 INDEX UPDATED              │
│  knowledge_fts virtual table     │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  AVAILABLE FOR SEARCH            │
│  Real-time, ranked results       │
└──────────────────────────────────┘


SEARCH & RETRIEVAL
┌──────────────────────────────────┐
│  User Enters Search Query        │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  FTS5 Query Engine               │
│  • Tokenization (Porter stemmer) │
│  • Boolean logic                 │
│  • Proximity matching            │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  BM25 Ranking Algorithm          │
│  • Score by relevance            │
│  • Title > Content weight        │
│  • Rare terms weighted higher    │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  Result Enhancement              │
│  • Highlight matches             │
│  • Generate snippets             │
│  • Fetch metadata                │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  Apply Filters                   │
│  • Equipment type                │
│  • Difficulty level              │
│  • Safety level                  │
└────────────────┬─────────────────┘
                 │
                 ▼
┌──────────────────────────────────┐
│  Display Results to User         │
│  • Ranked by relevance           │
│  • Highlighted matches           │
│  • Rich metadata badges          │
└──────────────────────────────────┘
```

---

## Database Schema Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        DATABASE SCHEMA v12                              │
└─────────────────────────────────────────────────────────────────────────┘

CORE TABLES
╔════════════════════════╗
║ knowledge_entries      ║ PRIMARY TABLE
║ ────────────────────── ║
║ • id (PK)              ║ 45 total fields including:
║ • title                ║ - Core: title, content, summary
║ • content              ║ - Taxonomy: category, equipment, manufacturer
║ • summary              ║ - Classification: difficulty, safety, service type
║ • category_id (FK)     ║ - Procedure: time, tools, parts, prerequisites
║ • equipment_type       ║ - Authoring: author, reviewer, review status
║ • manufacturer         ║ - Analytics: via entry_metadata
║ • difficulty_level     ║ - Versioning: version, created/updated timestamps
║ • safety_level         ║
║ • service_type         ║
║ • + 35 more fields     ║
╚══════════╦═════════════╝
           ║
           ║ 1:1
           ▼
┌──────────────────────┐       ┌──────────────────────┐
│ entry_metadata       │       │ knowledge_fts        │
│ ──────────────────── │       │ (FTS5 Virtual Table) │
│ • entry_id (PK/FK)   │       │ ──────────────────── │
│ • view_count         │       │ • title (indexed)    │
│ • helpful_count      │       │ • content (indexed)  │
│ • not_helpful_count  │       │ • summary (indexed)  │
│ • last_viewed_at     │       │ • category (indexed) │
│ • search_terms       │       │ • equipment (indexed)│
│ • completeness_score │       │ • symptoms (indexed) │
│ • needs_review       │       │ • tags (indexed)     │
└──────────────────────┘       └──────────────────────┘
           ▲                              ▲
           │ Analytics                    │ Triggers
           │                              │ (auto-sync)


HIERARCHY & TAXONOMY
╔════════════════════════╗
║ knowledge_categories   ║ SELF-REFERENCING
║ ────────────────────── ║
║ • id (PK)              ║ 3-Level Hierarchy:
║ • name                 ║ L1: Equipment/Service Domain
║ • parent_id (FK →self) ║ L2: Type/Category
║ • level (1, 2, or 3)   ║ L3: Manufacturer/Specific
║ • path (materialized)  ║
║ • icon                 ║ Examples:
║ • color                ║ /cash-handling
║ • sort_order           ║ /cash-handling/atm-tcr
║ • article_count        ║ /cash-handling/atm-tcr/hyosung
╚══════════╦═════════════╝
           ║ FK
           ▼
┌─────────────────────────────────┐
│ knowledge_entries.category_id   │
└─────────────────────────────────┘


TAGGING SYSTEM (Many-to-Many)
╔═══════════════════╗
║ knowledge_tags    ║
║ ───────────────── ║
║ • id (PK)         ║ Examples:
║ • name            ║ - error-codes
║ • slug            ║ - quick-fix
║ • color           ║ - safety-critical
║ • usage_count     ║ - warranty-service
╚═════════╦═════════╝
          ║
          ║ Many-to-Many via:
          ║
          ▼
┌───────────────────┐
│ entry_tags        │ JUNCTION TABLE
│ ─────────────────  │
│ • entry_id (FK)   │
│ • tag_id (FK)     │
│ • tagged_at       │
│ (Composite PK)    │
└───────────────────┘
          ║
          ▼
┌───────────────────┐
│ knowledge_entries │
└───────────────────┘


SUPPORTING TABLES
┌──────────────────────┐      ┌──────────────────────┐
│ knowledge_attachments│      │ knowledge_history    │
│ ──────────────────── │      │ ──────────────────── │
│ • id (PK)            │      │ • id (PK)            │
│ • entry_id (FK)      │      │ • entry_id (FK)      │
│ • file_name          │      │ • change_type        │
│ • file_path          │      │ • field_name         │
│ • file_type          │      │ • old_value          │
│ • file_size          │      │ • new_value          │
│ • alt_text           │      │ • changed_by         │
│ • uploaded_at        │      │ • changed_at         │
└──────────────────────┘      │ • version_before     │
                              │ • version_after      │
                              └──────────────────────┘

┌──────────────────────┐
│ knowledge_relations  │
│ ──────────────────── │
│ • id (PK)            │
│ • from_entry_id (FK) │
│ • to_entry_id (FK)   │
│ • relation_type      │
│   - related          │
│   - prerequisite     │
│   - follow_up        │
│   - supersedes       │
│ • strength (0-100)   │
└──────────────────────┘
```

---

## Search Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                      FTS5 SEARCH ARCHITECTURE                           │
└─────────────────────────────────────────────────────────────────────────┘

USER INPUT
┌───────────────────┐
│ Search Box        │
│ "atm card error"  │
└────────┬──────────┘
         │
         ▼
┌───────────────────────────┐
│ Query Parser              │
│ • Split into tokens       │
│ • Identify operators      │
│ • Apply stemming (Porter) │
└────────┬──────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ FTS5 Query Execution              │
│ knowledge_fts MATCH 'atm card'    │
│                                   │
│ Tokenization:                     │
│ "atm" → atm                       │
│ "card" → card                     │
│ "error" → error, err (stemming)   │
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ Index Lookup                      │
│                                   │
│ token_positions table:            │
│ ┌─────┬────────┬──────┬─────────┐│
│ │token│column  │rowid │position ││
│ ├─────┼────────┼──────┼─────────┤│
│ │atm  │title   │  1   │   0     ││
│ │atm  │content │  1   │  15     ││
│ │card │content │  1   │  42     ││
│ │error│title   │  1   │   2     ││
│ └─────┴────────┴──────┴─────────┘│
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ BM25 Ranking                      │
│                                   │
│ score = IDF(term) × TF(doc, term) │
│                                   │
│ Factors:                          │
│ • Term frequency in document      │
│ • Inverse document frequency      │
│ • Document length normalization   │
│ • Field weights (title > content) │
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ Result Enhancement                │
│                                   │
│ For each match:                   │
│ • highlight() marks <mark>term    │
│ • snippet() extracts context      │
│ • Fetch metadata (view count,     │
│   helpful votes, etc.)            │
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ Apply Filters                     │
│                                   │
│ WHERE equipment_type = 'ATM/TCR'  │
│   AND difficulty_level IN (...)   │
│   AND safety_level IN (...)       │
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ Sorted Results                    │
│                                   │
│ ORDER BY bm25(kf) ASC             │
│ LIMIT 50                          │
│                                   │
│ [Most relevant first]             │
└────────┬──────────────────────────┘
         │
         ▼
┌───────────────────────────────────┐
│ Display to User                   │
│                                   │
│ • Highlighted title               │
│ • Content snippet with matches    │
│ • Metadata badges                 │
│ • Relevance score (internal)      │
└───────────────────────────────────┘
```

---

## Category Navigation Flow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    HIERARCHICAL CATEGORY BROWSER                        │
└─────────────────────────────────────────────────────────────────────────┘

LEVEL 1: Equipment/Service Domains
┌──────────────────────────────────────────────────────────────────┐
│  Knowledge Base Home                                             │
├──────────────────────────────────────────────────────────────────┤
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │ 🏦 Cash        │  │ 🔒 Security    │  │ 🛡️ Vault       │     │
│  │ Handling       │  │ Systems        │  │ Equipment      │     │
│  │ [145 articles] │  │ [67 articles]  │  │ [43 articles]  │     │
│  └───────┬────────┘  └────────────────┘  └────────────────┘     │
│          │ (click)                                               │
│          ▼                                                        │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │ ⚙️ Computing   │  │ 🔧 Trouble-    │  │ 🛠️ Maintenance │     │
│  │ Systems        │  │ shooting       │  │                │     │
│  │ [28 articles]  │  │ [156 articles] │  │ [98 articles]  │     │
│  └────────────────┘  └────────────────┘  └────────────────┘     │
└──────────────────────────────────────────────────────────────────┘

LEVEL 2: Equipment Types / Procedure Types
┌──────────────────────────────────────────────────────────────────┐
│  Cash Handling Equipment > [Back]                                │
├──────────────────────────────────────────────────────────────────┤
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │ 🏧 ATM/TCR     │  │ 🪙 Coin        │  │ 💵 Currency    │     │
│  │                │  │ Sorters        │  │ Counters       │     │
│  │ [78 articles]  │  │ [45 articles]  │  │ [22 articles]  │     │
│  └───────┬────────┘  └────────────────┘  └────────────────┘     │
│          │ (click)                                               │
│          ▼                                                        │
└──────────────────────────────────────────────────────────────────┘

LEVEL 3: Manufacturers / Specific Types
┌──────────────────────────────────────────────────────────────────┐
│  Cash Handling > ATM/TCR > [Back]                                │
├──────────────────────────────────────────────────────────────────┤
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐     │
│  │ Hyosung        │  │ NCR            │  │ Diebold        │     │
│  │ [35 articles]  │  │ [28 articles]  │  │ [15 articles]  │     │
│  └────────────────┘  └────────────────┘  └────────────────┘     │
│                                                                  │
│  Articles in this category:                                      │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ • How to Clear Error Code E-0042                           │  │
│  │ • Daily Preventive Maintenance Checklist                   │  │
│  │ • Card Reader Replacement Procedure                        │  │
│  │ • ... (all Hyosung ATM articles)                           │  │
│  └────────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────────┘

BREADCRUMB TRAIL
┌──────────────────────────────────────────────────────────────────┐
│ [< Back] Cash Handling > ATM/TCR > Hyosung                       │
└──────────────────────────────────────────────────────────────────┘
                  ▲           ▲        ▲
                  │           │        │
              Level 1     Level 2  Level 3
```

---

## Article Display Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         ARTICLE VIEW LAYOUT                             │
└─────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ [< Back] How to Clear Error Code E-0042 | [Print] [Share]       │
├──────────────────────────────────────────────────────────────────┤
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ METADATA HEADER (GlassCard)                                  │ │
│ │                                                              │ │
│ │ 📁 Cash Handling > ATM/TCR > Hyosung                         │ │
│ │                                                              │ │
│ │ How to Clear Error Code E-0042 on Hyosung ATM               │ │
│ │                                                              │ │
│ │ 🏧 ATM / TCR • Hyosung                                       │ │
│ │                                                              │ │
│ │ [●●○○ Intermediate] [⏱ 20 min] [⚠ CAUTION]                  │ │
│ │ [🔧 Troubleshooting]                                         │ │
│ │                                                              │ │
│ │ Tags: [error-codes] [card-reader] [diagnostics]             │ │
│ │                                                              │ │
│ │ ──────────────────────────────────────────────────────────   │ │
│ │ By John Smith (Senior Tech) | Reviewed by Jane Doe          │ │
│ │ v2.1 | Updated 2 days ago | 234 views | 45 👍               │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ TABLE OF CONTENTS                                            │ │
│ │ 1. Symptoms                                                  │ │
│ │ 2. Diagnostic Procedure                                      │ │
│ │ 3. Resolution                                                │ │
│ │ 4. Verification                                              │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ ⚠️ CAUTION                                                    │ │
│ │ Exercise caution when performing this procedure.             │ │
│ │ Disconnect power before opening panels.                      │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ REQUIRED TOOLS & PARTS                                       │ │
│ │ Tools:                                                       │ │
│ │ • Phillips screwdriver #2                                    │ │
│ │ • Digital multimeter                                         │ │
│ │ Parts:                                                       │ │
│ │ • Cleaning card (CR-CLEAN-001)                               │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ ARTICLE CONTENT (Enhanced Markdown)                          │ │
│ │                                                              │ │
│ │ ## Symptoms                                                  │ │
│ │ This error typically manifests as:                           │ │
│ │ • Card reader not reading                                    │ │
│ │ • Error code E-0042                                          │ │
│ │                                                              │ │
│ │ ## Diagnostic Procedure                                      │ │
│ │ ### Step 1: Visual Inspection                                │ │
│ │ 1. Open front panel                                          │ │
│ │ 2. Locate card reader                                        │ │
│ │                                                              │ │
│ │ ```bash                                                      │ │
│ │ # Access diagnostic mode                                     │ │
│ │ MENU > DIAGNOSTICS > CARD_READER_TEST                        │ │
│ │ ```                                                          │ │
│ │                                                              │ │
│ │ [Full content continues...]                                  │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ RELATED ARTICLES                                             │ │
│ │ 📄 Card Reader Replacement Procedure                         │ │
│ │ 📄 ATM Error Code Reference Guide                            │ │
│ │ 📄 Hyosung MX8600 Maintenance Schedule                       │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ WAS THIS HELPFUL?                                            │ │
│ │           [👍 Yes]         [👎 No]                           │ │
│ └──────────────────────────────────────────────────────────────┘ │
│                                                                  │
│ ┌──────────────────────────────────────────────────────────────┐ │
│ │ DOCUMENT INFORMATION                                         │ │
│ │ Document ID:   hyosung-atm-card-reader-e0042                 │ │
│ │ Source:        hyosung_mx8600_troubleshooting.pdf            │ │
│ │ Status:        published                                     │ │
│ └──────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────┘
```

---

## Import Pipeline Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        IMPORT PIPELINE FLOW                             │
└─────────────────────────────────────────────────────────────────────────┘

FILE SYSTEM                    IMPORT ENGINE                  DATABASE
┌──────────────┐              ┌──────────────┐              ┌──────────────┐
│ Staging Dir  │              │ Scanner      │              │ SQLite DB    │
│              │              │              │              │              │
│ *.md files   │─────────────►│ • Recursive  │              │ Tables:      │
│ + metadata   │  File list   │   scan       │              │ • entries    │
│              │              │ • Filter     │              │ • categories │
└──────────────┘              │   exclusions │              │ • tags       │
                              └──────┬───────┘              │ • metadata   │
                                     │                      │ • fts5       │
                                     ▼                      └──────────────┘
                              ┌──────────────┐                     ▲
                              │ Parser       │                     │
                              │              │                     │
                              │ • YAML front │                     │
                              │ • Markdown   │                     │
                              │   body       │                     │
                              └──────┬───────┘                     │
                                     │                             │
                                     ▼                             │
                              ┌──────────────┐                     │
                              │ Validator    │                     │
                              │              │                     │
                              │ • Required   │                     │
                              │   fields     │                     │
                              │ • Format     │                     │
                              │ • Enums      │                     │
                              └──────┬───────┘                     │
                                     │                             │
                                     ▼                             │
                              ┌──────────────┐                     │
                              │ Enricher     │                     │
                              │              │                     │
                              │ • Generate   │                     │
                              │   defaults   │                     │
                              │ • Extract    │                     │
                              │   summary    │                     │
                              │ • Detect     │                     │
                              │   images     │                     │
                              │ • Convert    │                     │
                              │   arrays     │                     │
                              └──────┬───────┘                     │
                                     │                             │
                                     ▼                             │
                              ┌──────────────┐                     │
                              │ Conflict     │                     │
                              │ Detector     │                     │
                              │              │                     │
                              │ • Check ID   │                     │
                              │ • Compare    │                     │
                              │   version    │                     │
                              │ • Diff       │                     │
                              │   content    │                     │
                              └──────┬───────┘                     │
                                     │                             │
                          ┌──────────┴──────────┐                  │
                          │                     │                  │
                          ▼                     ▼                  │
                   ┌─────────────┐      ┌─────────────┐           │
                   │ Create      │      │ Update      │           │
                   │ New Entry   │      │ Existing    │           │
                   └──────┬──────┘      └──────┬──────┘           │
                          │                    │                  │
                          └─────────┬──────────┘                  │
                                    │                             │
                                    ▼                             │
                             ┌─────────────┐                      │
                             │ Upsert to   │──────────────────────┘
                             │ Database    │
                             └──────┬──────┘
                                    │
                                    ▼
                             ┌─────────────┐
                             │ Triggers    │
                             │ Execute     │
                             │             │
                             │ • FTS5 sync │
                             │ • Metadata  │
                             │ • History   │
                             └──────┬──────┘
                                    │
                                    ▼
                             ┌─────────────┐
                             │ Report      │
                             │ Results     │
                             │             │
                             │ Created: 12 │
                             │ Updated: 5  │
                             │ Skipped: 3  │
                             │ Errors: 0   │
                             └─────────────┘
```

---

## Metadata Field Map

```
┌─────────────────────────────────────────────────────────────────────────┐
│              KNOWLEDGE ENTRY METADATA FIELD MAP (45 Fields)             │
└─────────────────────────────────────────────────────────────────────────┘

IDENTIFICATION       TAXONOMY             CLASSIFICATION
┌──────────────┐    ┌──────────────┐     ┌──────────────────┐
│ id           │    │ category_id  │     │ service_type     │
│ title        │    │ category     │     │ difficulty_level │
│ summary      │    │ equipment    │     │ priority_level   │
│ version      │    │ manufacturer │     │ safety_level     │
│ status       │    │ model        │     │ compliance_tags  │
└──────────────┘    │ applicable   │     └──────────────────┘
                    └──────────────┘

PROCEDURE            CONTENT              AUTHORING
┌──────────────────┐ ┌──────────────┐    ┌──────────────┐
│ est_time_min     │ │ content      │    │ author       │
│ required_tools   │ │ symptoms     │    │ author_role  │
│ required_parts   │ │ solutions    │    │ reviewer     │
│ prerequisites    │ │ has_images   │    │ reviewed_at  │
│ special_req      │ │ has_attach   │    │ review_status│
└──────────────────┘ └──────────────┘    │ approval_req │
                                         │ change_notes │
SOURCE/SYNC          TIMESTAMPS          └──────────────┘
┌──────────────┐    ┌──────────────┐
│ source_type  │    │ created_at   │
│ source_file  │    │ updated_at   │
│ external_id  │    │ published_at │
│ sync_source  │    │ archived_at  │
│ last_synced  │    └──────────────┘
└──────────────┘

ALL FIELDS FLOW INTO:
┌─────────────────────────────────────────┐
│ knowledge_fts (FTS5 Virtual Table)      │
│ Indexed: title, content, summary,       │
│ category, equipment, manufacturer,       │
│ symptoms, tags                          │
└─────────────────────────────────────────┘
```

---

## System Integration Map

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    FSC PORTAL SYSTEM INTEGRATION                        │
└─────────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────┐
│ MAIN APPLICATION                                                 │
│ (lib/main.dart)                                                  │
└────────────────────────────┬─────────────────────────────────────┘
                             │
                             ▼
┌──────────────────────────────────────────────────────────────────┐
│ NAVIGATION SYSTEM                                                │
│ Index 5: Knowledge Base                                          │
└────────────────────────────┬─────────────────────────────────────┘
                             │
                 ┌───────────┴───────────┐
                 │                       │
                 ▼                       ▼
┌─────────────────────────┐  ┌─────────────────────────┐
│ EnhancedKnowledgeHome   │  │ KnowledgeHomeView       │
│ (New - Recommended)     │  │ (Original - Legacy)     │
└───────────┬─────────────┘  └───────────┬─────────────┘
            │                            │
            ├─► FTS5 Search              ├─► Basic Search
            ├─► Category Browser         ├─► Equipment/Category List
            ├─► Advanced Filters         └─► Simple View Toggle
            └─► Autocomplete
            │
            ▼
┌───────────────────────────────────────┐
│ DATABASE (app_database.dart)          │
│ • FTS5 search methods                 │
│ • Category hierarchy queries          │
│ • Metadata retrieval                  │
│ • Analytics tracking                  │
└───────────┬───────────────────────────┘
            │
            ├─► knowledge_entries (main table)
            ├─► knowledge_fts (FTS5 index)
            ├─► knowledge_categories (hierarchy)
            ├─► knowledge_tags (tags)
            ├─► entry_tags (junction)
            ├─► entry_metadata (analytics)
            ├─► knowledge_attachments (files)
            ├─► knowledge_history (audit)
            └─► knowledge_relations (links)


IMPORT PIPELINE
┌──────────────────────────────────────┐
│ Import UI (Admin/Settings)           │
└───────────┬──────────────────────────┘
            │
            ▼
┌──────────────────────────────────────┐
│ KnowledgeImportUtility               │
│ • Parse frontmatter                  │
│ • Validate metadata                  │
│ • Process arrays                     │
│ • Upsert to database                 │
└───────────┬──────────────────────────┘
            │
            ▼
┌──────────────────────────────────────┐
│ Database Triggers                    │
│ • Sync FTS5 index                    │
│ • Create metadata record             │
│ • Log to history                     │
└──────────────────────────────────────┘


CATEGORY SEEDING
┌──────────────────────────────────────┐
│ seed_service.dart                    │
│ • Orchestrates seeding               │
└───────────┬──────────────────────────┘
            │
            ▼
┌──────────────────────────────────────┐
│ knowledge_category_seed.dart         │
│ • Equipment hierarchy (40+ cats)     │
│ • Service hierarchy                  │
│ • Common tags (20+)                  │
└──────────────────────────────────────┘
```

---

## Legend

```
SYMBOLS USED IN DIAGRAMS:

┌─┐│└┘├┤┬┴┼     Box drawing characters
═══            Emphasized borders
[Component]     UI element or button
{Data}          Dynamic/variable content
●               Status indicator
🔷 🔒 🛡️ 🏧      Icon representations
→ ▼ ▲          Flow direction arrows
(FK)            Foreign key
(PK)            Primary key
```

---

**End of Architecture Diagrams**
