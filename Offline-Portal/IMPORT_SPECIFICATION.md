# Knowledge Base Import Specification

**Version:** 1.0  
**Last Updated:** January 31, 2026  
**Purpose:** Technical specification for knowledge base file format and import process

---

## Table of Contents

1. [File Format](#file-format)
2. [Directory Structure](#directory-structure)
3. [Metadata Requirements](#metadata-requirements)
4. [Content Guidelines](#content-guidelines)
5. [Import Process](#import-process)
6. [Validation Rules](#validation-rules)
7. [Error Handling](#error-handling)

---

## File Format

### Markdown with YAML Frontmatter

**File Extension:** `.md`  
**Encoding:** UTF-8  
**Line Endings:** LF or CRLF (both supported)

**Structure:**
```
---
[YAML frontmatter with metadata]
---
[Markdown content body]
```

### Example File

```markdown
---
id: example-article-001
title: "Example Knowledge Article"
category: "Troubleshooting"
equipment_type: "ATM / TCR"
version: "1.0.0"
status: "active"
---

# Example Knowledge Article

## Content goes here...
```

---

## Directory Structure

### Recommended Staging Directory

**Path:** `C:\Portal_Knowledge_Staging\`

**Structure:**
```
C:\Portal_Knowledge_Staging\
├── knowledge_entries\
│   ├── equipment\
│   │   ├── atm\
│   │   │   ├── hyosung\
│   │   │   │   ├── error_e0042.md
│   │   │   │   ├── daily_maintenance.md
│   │   │   │   └── ...
│   │   │   ├── ncr\
│   │   │   └── diebold\
│   │   ├── coin_sorter\
│   │   │   ├── jetsort\
│   │   │   └── kisan\
│   │   ├── currency_counter\
│   │   └── validators\
│   ├── procedures\
│   │   ├── troubleshooting\
│   │   ├── maintenance\
│   │   ├── installation\
│   │   └── safety\
│   └── reference\
│       ├── parts_catalogs\
│       ├── specifications\
│       └── diagrams\
└── attachments\
    ├── images\
    │   ├── error_e0042_display.jpg
    │   └── card_reader_location.png
    └── pdfs\
        └── hyosung_mx8600_manual.pdf
```

### Directory Naming Conventions

- **Lowercase** with underscores
- **No spaces** in folder names
- **Organize by equipment first**, then by manufacturer
- **Separate procedures** folder for task-based organization

### Files to Exclude

The importer automatically skips:
- `_logs\` folders
- `_unclassified\` folders
- `phase4-database\` folders
- `temp\` or `tmp\` folders
- Files not ending in `.md`

---

## Metadata Requirements

### Required Fields

**Always required:**
```yaml
id: unique-identifier
title: "Article Title"
category: "Category Name"
equipment_type: "Equipment Type"
source_type: "manual_import"
source_file: "filename.md"
version: "1.0.0"
status: "active"
```

### Optional but Recommended

**Classification:**
```yaml
manufacturer: "Hyosung"
equipment_model: "MX8600"
applicable_models: ["MX8600", "MX8600T"]
service_type: "troubleshooting"
difficulty_level: "intermediate"
priority_level: "high"
safety_level: "caution"
```

**Procedure Details:**
```yaml
estimated_time_minutes: 20
required_tools: ["Phillips screwdriver", "Multimeter"]
required_parts: ["Cleaning card (CR-CLEAN-001)"]
prerequisites: "atm-basic-access,electrical-safety"
symptoms: "Card reader error, jam, malfunction"
```

**Authoring:**
```yaml
author: "John Smith"
author_role: "Senior Technician"
reviewer: "Jane Doe"
reviewed_at: "2026-01-15"
review_status: "published"
```

### Field Defaults

If fields are missing, the importer provides defaults:

| Field | Default Value | Source |
|-------|---------------|--------|
| id | Generated | From filename |
| title | Generated | From first H1 or filename |
| category | Guessed | From file path |
| equipment_type | Guessed | From file path |
| source_type | `manual_import` | Fixed |
| source_file | Filename | From file |
| version | `1.0.0` | Fixed |
| status | `active` | Fixed |
| service_type | `reference` | Fixed |
| difficulty_level | `intermediate` | Fixed |
| priority_level | `standard` | Fixed |
| safety_level | `none` | Fixed |
| review_status | `draft` | Fixed |

---

## Content Guidelines

### Frontmatter Format

**Must use:**
- Triple dashes (`---`) before and after
- Valid YAML syntax
- Consistent indentation (2 spaces)
- Quoted strings for values with special characters

**Example:**
```yaml
---
id: article-id
title: "Article with: Special Characters"
category: "Troubleshooting"
required_tools: ["Tool 1", "Tool 2"]
---
```

### Markdown Body

**Supported features:**
- Headings (H1-H6)
- Bold, italic, code
- Lists (ordered, unordered, checklists)
- Code blocks with syntax highlighting
- Tables
- Blockquotes
- Horizontal rules
- Links (internal and external)

**Partially supported:**
- Images (referenced but not yet displayed)
- HTML (limited support)

**Not supported:**
- Embedded videos
- Interactive elements
- Custom HTML/CSS

### Image References

**Format:**
```markdown
![Alt text](../attachments/images/error_display.jpg)
```

**Requirements:**
- Use relative paths
- Store images in `attachments/images/`
- Use descriptive filenames
- Supported formats: jpg, png, gif, svg

---

## Import Process

### Import Flow

```
1. Scan staging directory recursively
        ↓
2. Find all .md files
        ↓
3. For each file:
    a. Parse YAML frontmatter
    b. Extract markdown body
    c. Apply defaults for missing fields
    d. Validate required fields
    e. Check if entry exists
    f. Create new or update existing
    g. Update FTS5 index (automatic via triggers)
    h. Create metadata record
        ↓
4. Report results (created, updated, skipped, errors)
```

### Update Detection

An entry is updated if:
- Version number changed
- Content body changed
- Any metadata field changed

An entry is skipped if:
- Identical version and content
- All metadata matches

### Conflict Resolution

**Same ID, different content:**
- Newer version wins (by version number)
- If versions equal, file system version replaces database

**No conflict resolution needed:**
- Offline-first architecture
- Single source of truth (file system)
- Database is a cache of file system content

---

## Validation Rules

### ID Format

**Rules:**
- Lowercase only
- Alphanumeric characters and hyphens
- No spaces, underscores, or special characters
- Maximum 100 characters
- Must be unique

**Valid:**
- `hyosung-atm-error-e0042`
- `daily-maintenance-checklist-atm`
- `card-reader-replacement-001`

**Invalid:**
- `Hyosung_ATM_Error` (uppercase, underscores)
- `hyosung atm error` (spaces)
- `hyosung/atm/error` (slashes)

### Version Format

**Rules:**
- Semantic versioning: MAJOR.MINOR.PATCH
- All three components required
- Numeric only

**Valid:**
- `1.0.0`
- `2.3.15`
- `10.0.1`

**Invalid:**
- `1.0` (missing patch)
- `v1.0.0` (prefix)
- `1.0.0-beta` (suffix not supported yet)

### Enum Values

**service_type:** Must be one of:
- `maintenance`
- `troubleshooting`
- `installation`
- `reference`
- `safety`

**difficulty_level:** Must be one of:
- `beginner`
- `intermediate`
- `advanced`
- `expert`

**priority_level:** Must be one of:
- `critical`
- `high`
- `standard`
- `low`

**safety_level:** Must be one of:
- `none`
- `caution`
- `warning`
- `danger`

**review_status:** Must be one of:
- `draft`
- `pending_review`
- `changes_requested`
- `approved`
- `published`
- `archived`

**status:** Must be one of:
- `active`
- `inactive`
- `deprecated`

### Array Fields

**Format:** YAML array syntax

**Example:**
```yaml
required_tools: ["Tool 1", "Tool 2", "Tool 3"]
applicable_models: ["MX8600", "MX8600T"]
compliance_tags: ["OSHA", "ISO9001"]
```

**Stored as:** JSON string in database

---

## Error Handling

### Import Errors

**File not parseable:**
- Error logged with filename and parse error
- File skipped
- Import continues with next file

**Missing required fields:**
- Warning logged
- Defaults applied
- Entry created with partial data

**Duplicate ID:**
- Treated as update
- Version comparison performed
- Entry updated if different

**Database error:**
- Error logged with stack trace
- Entry skipped
- Import continues

### Error Log Location

**During import:**
- Errors displayed in import UI
- Full stack traces in console

**Import results:**
- Created: List of successfully created entries
- Updated: List of successfully updated entries
- Skipped: List of unchanged entries
- Errors: List of files with errors and error messages

---

## Import Methods

### Method 1: Admin UI Import

**Location:** Settings > Knowledge > "Ingest from File System"  
or Home > Tactical Shortcuts > "Agent Tools"

**Process:**
1. Enter staging directory path
2. Click "Run Import"
3. View progress and results
4. Review errors if any

**Recommended for:**
- Manual imports
- Testing new articles
- One-time bulk imports

### Method 2: Settings Import

**Location:** Settings > Knowledge > "Rebuild Knowledge Index"

**Process:**
- Uses default path: `C:\Portal_Knowledge_Staging`
- One-click import
- Results shown in snackbar

**Recommended for:**
- Quick refreshes
- Standard import path

### Method 3: Command-Line Scripts

**Scripts available:**
- `lib/scripts/ingest_knowledge_flutter.dart`
- `lib/scripts/force_ingest_knowledge.dart`

**Usage:**
```bash
dart run lib/scripts/ingest_knowledge_flutter.dart
```

**Recommended for:**
- Automation
- Batch processing
- CI/CD pipelines

---

## Best Practices

### File Organization

**Do:**
- Organize by equipment hierarchy
- Use manufacturer folders
- Keep related articles together
- Use descriptive filenames

**Don't:**
- Mix equipment types in same folder
- Use generic filenames (article1.md)
- Nest too deeply (max 3-4 levels)

### Metadata Management

**Do:**
- Fill all recommended fields
- Use consistent terminology
- Include version history in content
- Provide realistic time estimates
- List all required tools and parts

**Don't:**
- Leave required fields empty
- Use inconsistent category names
- Skip safety level for hazardous procedures
- Forget to update version on changes

### Content Quality

**Do:**
- Write for your audience (field technicians)
- Use clear, concise language
- Include visual aids (diagrams, photos)
- Provide multiple solutions when applicable
- Include verification steps

**Don't:**
- Write assuming expert knowledge (unless difficulty=expert)
- Use jargon without explanation
- Skip safety warnings
- Omit troubleshooting steps

---

## Migration from Old Format

### Converting Existing Articles

If you have articles in old format (no frontmatter):

**Option 1: Add frontmatter manually**
1. Add `---` at top of file
2. Add required metadata
3. Add closing `---`
4. Keep existing content

**Option 2: Let importer generate defaults**
1. Import as-is
2. Review generated metadata
3. Edit and re-import with corrections

### Updating Metadata

To update metadata for existing entries:
1. Edit the source `.md` file
2. Increment version number
3. Re-import from staging directory
4. Importer will detect changes and update

---

## Appendix: Complete Metadata Reference

```yaml
---
# IDENTIFICATION
id: "unique-article-id"
title: "Article Title"
version: "1.0.0"
status: "active"

# TAXONOMY
category: "Troubleshooting"
equipment_type: "ATM / TCR"
manufacturer: "Hyosung"
equipment_model: "MX8600"
applicable_models: ["MX8600", "MX8600T"]

# CLASSIFICATION
service_type: "troubleshooting"
difficulty_level: "intermediate"
priority_level: "high"
safety_level: "caution"
compliance_tags: ["OSHA", "manufacturer_warranty"]

# PROCEDURE
estimated_time_minutes: 20
required_tools: ["Phillips screwdriver", "Multimeter"]
required_parts: ["Cleaning card"]
prerequisites: "article-id-1,article-id-2"
special_requirements: "Supervisor approval required"

# CONTENT
symptoms: "Symptom 1, Symptom 2, Symptom 3"
solutions_count: 3

# AUTHORING
author: "John Smith"
author_role: "Senior Technician"
reviewer: "Jane Doe"
reviewed_at: "2026-01-15"
review_status: "published"
approval_required: false
change_notes: "Updated steps 3-5"

# SOURCE
source_type: "manual_import"
source_file: "original_filename.md"
external_id: "EXTERNAL-REF-001"
sync_source: "file_system"
---
```

---

**End of Import Specification**
