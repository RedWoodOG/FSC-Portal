# Knowledge Base Schema Documentation

**Version:** 3.0.0 (Enhanced)  
**Last Updated:** January 31, 2026  
**Purpose:** Complete database schema reference for the enhanced knowledge base system

---

## Table of Contents

1. [Schema Overview](#schema-overview)
2. [Core Tables](#core-tables)
3. [Supporting Tables](#supporting-tables)
4. [Virtual Tables (FTS5)](#virtual-tables-fts5)
5. [Relationships](#relationships)
6. [Indexes](#indexes)
7. [Triggers](#triggers)
8. [Migration Guide](#migration-guide)

---

## Schema Overview

### Entity Relationship Diagram

```
┌──────────────────────┐
│ KnowledgeEntries     │
│ (Main Content)       │
└──────────┬───────────┘
           │
           ├───────────┐
           │           │
           ▼           ▼
┌──────────────────┐  ┌──────────────────┐
│ knowledge_fts    │  │ EntryMetadata    │
│ (FTS5 Search)    │  │ (Extended Info)  │
└──────────────────┘  └──────────────────┘
           │
           ├───────────┬───────────────┬──────────────┐
           │           │               │              │
           ▼           ▼               ▼              ▼
┌─────────────┐ ┌──────────────┐ ┌─────────────┐ ┌─────────────┐
│ Categories  │ │ Tags         │ │ Attachments │ │ History     │
│ (Hierarchy) │ │ (via Junction│ │ (Files)     │ │ (Audit)     │
└─────────────┘ │   EntryTags) │ └─────────────┘ └─────────────┘
                └──────────────┘
           │
           ▼
┌──────────────────┐
│ Relations        │
│ (Related Docs)   │
└──────────────────┘
```

---

## Core Tables

### 1. KnowledgeEntries (Enhanced)

**Purpose:** Main table storing all knowledge base articles with enhanced metadata

**Table Definition:**

```dart
class KnowledgeEntries extends Table {
  // PRIMARY IDENTIFICATION
  TextColumn get id => text()();  // Primary key: unique-article-id
  
  // CORE CONTENT
  TextColumn get title => text()();
  TextColumn get content => text()();  // Full markdown body
  TextColumn get summary => text().withDefault(const Constant(''))();  // First 200 chars
  
  // TAXONOMY & CLASSIFICATION
  IntColumn get categoryId => integer().nullable().references(KnowledgeCategories, #id)();
  TextColumn get category => text()();  // Legacy, kept for backward compatibility
  TextColumn get equipmentType => text()();
  TextColumn get equipmentModel => text().nullable()();
  TextColumn get manufacturer => text().nullable()();
  TextColumn get applicableModels => text().nullable()();  // JSON array
  
  // SERVICE CLASSIFICATION
  TextColumn get serviceType => text().withDefault(const Constant('reference'))();
  // Values: maintenance, troubleshooting, installation, reference, safety
  
  TextColumn get difficultyLevel => text().withDefault(const Constant('intermediate'))();
  // Values: beginner, intermediate, advanced, expert
  
  TextColumn get priorityLevel => text().withDefault(const Constant('standard'))();
  // Values: critical, high, standard, low
  
  TextColumn get safetyLevel => text().withDefault(const Constant('none'))();
  // Values: none, caution, warning, danger
  
  TextColumn get complianceTags => text().nullable()();  // JSON array
  // Example: ["OSHA", "ISO9001", "manufacturer_warranty"]
  
  // PROCEDURE METADATA
  IntColumn get estimatedTimeMinutes => integer().nullable()();
  TextColumn get requiredTools => text().nullable()();  // JSON array
  TextColumn get requiredParts => text().nullable()();  // JSON array
  TextColumn get prerequisites => text().nullable()();  // Comma-separated entry IDs
  TextColumn get specialRequirements => text().nullable()();
  
  // CONTENT STRUCTURE
  TextColumn get symptoms => text().nullable()();  // For troubleshooting articles
  IntColumn get solutionsCount => integer().withDefault(const Constant(1))();
  BoolColumn get hasImages => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAttachments => boolean().withDefault(const Constant(false))();
  
  // AUTHORING & QUALITY CONTROL
  TextColumn get author => text().nullable()();
  TextColumn get authorRole => text().nullable()();
  TextColumn get reviewer => text().nullable()();
  DateTimeColumn get reviewedAt => dateTime().nullable()();
  TextColumn get reviewStatus => text().withDefault(const Constant('draft'))();
  // Values: draft, pending_review, changes_requested, approved, published, archived
  
  BoolColumn get approvalRequired => boolean().withDefault(const Constant(false))();
  TextColumn get changeNotes => text().nullable()();
  
  // SOURCE & SYNC
  TextColumn get sourceType => text()();  // Existing
  TextColumn get sourceFile => text()();  // Existing
  TextColumn get externalId => text().nullable()();  // For external system sync
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  TextColumn get syncSource => text().nullable()();  // manual, api, file_system
  
  // VERSION CONTROL
  TextColumn get version => text()();  // Existing
  TextColumn get status => text()();   // Existing: active, inactive, deprecated
  
  // TIMESTAMPS
  DateTimeColumn get createdAt => dateTime()();  // Existing
  DateTimeColumn get updatedAt => dateTime()();  // Existing
  DateTimeColumn get publishedAt => dateTime().nullable()();
  DateTimeColumn get archivedAt => dateTime().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

**Key Changes from Current Schema:**
- Added 30+ new fields for rich metadata
- Maintains backward compatibility with existing fields
- All new fields are nullable or have defaults for safe migration

---

### 2. KnowledgeCategories (NEW)

**Purpose:** Hierarchical taxonomy supporting 3-level category organization

**Table Definition:**

```dart
class KnowledgeCategories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get slug => text().unique()();  // URL-friendly identifier
  
  // HIERARCHY
  IntColumn get parentId => integer().nullable().references(KnowledgeCategories, #id)();
  IntColumn get level => integer()();  // 1, 2, or 3
  TextColumn get path => text()();  // Materialized path: /parent/child/grandchild
  
  // DISPLAY
  TextColumn get icon => text().nullable()();  // Material icon name
  TextColumn get description => text().nullable()();
  TextColumn get color => text().nullable()();  // Hex color for theming
  
  // ORDERING & STATUS
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  
  // METADATA
  IntColumn get articleCount => integer().withDefault(const Constant(0))();  // Cached count
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
```

**Example Data:**

| id | name | slug | parentId | level | path |
|----|------|------|----------|-------|------|
| 1 | Cash Handling Equipment | cash-handling | NULL | 1 | /cash-handling |
| 2 | ATM / TCR | atm-tcr | 1 | 2 | /cash-handling/atm-tcr |
| 3 | Hyosung | hyosung | 2 | 3 | /cash-handling/atm-tcr/hyosung |
| 4 | NCR | ncr | 2 | 3 | /cash-handling/atm-tcr/ncr |

---

### 3. KnowledgeTags (NEW)

**Purpose:** Flexible tagging system for cross-cutting concerns

**Table Definition:**

```dart
class KnowledgeTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get slug => text().unique()();
  TextColumn get color => text().nullable()();  // Hex color for badge
  TextColumn get description => text().nullable()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();  // Cached
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}
```

**Example Tags:**
- error-codes
- card-reader
- diagnostics
- preventive-maintenance
- safety-critical
- warranty-service
- quick-fix
- advanced-procedure

---

### 4. EntryTags (NEW)

**Purpose:** Many-to-many junction table linking entries to tags

**Table Definition:**

```dart
class EntryTags extends Table {
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();
  IntColumn get tagId => integer().references(KnowledgeTags, #id)();
  DateTimeColumn get taggedAt => dateTime()();
  
  @override
  Set<Column> get primaryKey => {entryId, tagId};
}
```

---

### 5. EntryMetadata (NEW)

**Purpose:** Extended metadata and analytics for knowledge entries

**Table Definition:**

```dart
class EntryMetadata extends Table {
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();
  
  // USAGE ANALYTICS
  IntColumn get viewCount => integer().withDefault(const Constant(0))();
  IntColumn get helpfulCount => integer().withDefault(const Constant(0))();
  IntColumn get notHelpfulCount => integer().withDefault(const Constant(0))();
  IntColumn get averageTimeSeconds => integer().nullable()();  // Avg time spent
  DateTimeColumn get lastViewedAt => dateTime().nullable()();
  
  // SEARCH ANALYTICS
  TextColumn get searchTermsFound => text().withDefault(const Constant('[]'))();  // JSON array
  IntColumn get searchResultClicks => integer().withDefault(const Constant(0))();
  
  // QUALITY METRICS
  RealColumn get completenessScore => real().nullable()();  // 0-100
  BoolColumn get needsReview => boolean().withDefault(const Constant(false))();
  DateTimeColumn get nextReviewDue => dateTime().nullable()();
  
  // USER ENGAGEMENT
  IntColumn get uniqueViewers => integer().withDefault(const Constant(0))();
  IntColumn get returnVisitors => integer().withDefault(const Constant(0))();
  
  @override
  Set<Column> get primaryKey => {entryId};
}
```

---

## Supporting Tables

### 6. KnowledgeAttachments (NEW)

**Purpose:** File attachments (images, PDFs, diagrams) for articles

**Table Definition:**

```dart
class KnowledgeAttachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();
  
  // FILE INFORMATION
  TextColumn get fileName => text()();
  TextColumn get filePath => text()();  // Relative to attachments directory
  TextColumn get fileType => text()();  // image/jpeg, image/png, application/pdf, etc.
  IntColumn get fileSizeBytes => integer()();
  TextColumn get fileHash => text().nullable()();  // SHA-256 for deduplication
  
  // METADATA
  TextColumn get altText => text().nullable()();  // For images
  TextColumn get caption => text().nullable()();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();
  
  // CATEGORIZATION
  TextColumn get attachmentType => text()();  // diagram, photo, manual, reference
  BoolColumn get isInline => boolean().withDefault(const Constant(true))();  // Referenced in markdown
  
  // TIMESTAMPS
  DateTimeColumn get uploadedAt => dateTime()();
  TextColumn get uploadedBy => text().nullable()();
}
```

**Storage Location:** `%AppData%/portal_offline/knowledge_attachments/`

**File Naming Convention:** `{entry_id}_{timestamp}_{original_filename}`

---

### 7. KnowledgeHistory (NEW)

**Purpose:** Audit trail of all changes to knowledge entries

**Table Definition:**

```dart
class KnowledgeHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entryId => text().references(KnowledgeEntries, #id)();
  
  // CHANGE TRACKING
  TextColumn get changeType => text()();  // created, updated, published, archived
  TextColumn get fieldName => text().nullable()();  // Which field changed
  TextColumn get oldValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  TextColumn get changeNotes => text().nullable()();
  
  // AUTHOR INFO
  TextColumn get changedBy => text()();
  TextColumn get changedByRole => text().nullable()();
  DateTimeColumn get changedAt => dateTime()();
  
  // VERSION INFO
  TextColumn get versionBefore => text().nullable()();
  TextColumn get versionAfter => text().nullable()();
}
```

**Usage:**
- Triggered automatically on INSERT, UPDATE
- Manual entries for workflow state changes
- Enables version comparison and rollback

---

### 8. KnowledgeRelations (NEW)

**Purpose:** Link related articles together

**Table Definition:**

```dart
class KnowledgeRelations extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromEntryId => text().references(KnowledgeEntries, #id)();
  TextColumn get toEntryId => text().references(KnowledgeEntries, #id)();
  
  // RELATIONSHIP TYPE
  TextColumn get relationType => text()();
  // Values:
  //   - related: General relationship
  //   - prerequisite: Must read before this article
  //   - follow_up: Read after this article
  //   - supersedes: This article replaces the linked article
  //   - superseded_by: This article is replaced by the linked article
  //   - see_also: Additional reading
  
  // METADATA
  IntColumn get strength => integer().withDefault(const Constant(50))();  // 0-100
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get createdBy => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}
```

**Constraints:**
- Prevent self-referencing: fromEntryId != toEntryId
- Unique constraint on (fromEntryId, toEntryId, relationType)

---

## Virtual Tables (FTS5)

### 9. knowledge_fts (NEW)

**Purpose:** Full-text search index for fast, ranked search results

**Virtual Table Definition:**

```sql
CREATE VIRTUAL TABLE knowledge_fts USING fts5(
  title,
  content,
  summary,
  category,
  equipment_type,
  manufacturer,
  symptoms,
  tags,
  
  -- Configuration
  tokenize='porter unicode61 remove_diacritics 1',
  prefix='2 3 4',
  content='knowledge_entries',
  content_rowid='rowid'
);
```

**Tokenizer Configuration:**
- `porter`: Stemming (repair, repairs, repairing → repair)
- `unicode61`: Unicode normalization
- `remove_diacritics 1`: Remove accents (café → cafe)
- `prefix='2 3 4'`: Index 2-4 character prefixes for autocomplete

**Indexed Columns:**
1. title (highest weight in ranking)
2. content (main searchable text)
3. summary (for quick matching)
4. category (filterable)
5. equipment_type (filterable)
6. manufacturer (filterable)
7. symptoms (troubleshooting-specific)
8. tags (flexible classification)

**External Content Table:**
- Content stored in `knowledge_entries`
- FTS5 indexes pointers only (saves space)
- Automatic sync via triggers

---

## Relationships

### Primary Key Relationships

```
KnowledgeEntries (id: TEXT)
    │
    ├─► KnowledgeCategories (categoryId: INTEGER FK)
    │   └─► KnowledgeCategories (parentId: INTEGER FK, self-reference)
    │
    ├─► EntryTags (entryId: TEXT FK)
    │   └─► KnowledgeTags (tagId: INTEGER FK)
    │
    ├─► EntryMetadata (entryId: TEXT FK, 1:1)
    │
    ├─► KnowledgeAttachments (entryId: TEXT FK, 1:Many)
    │
    ├─► KnowledgeHistory (entryId: TEXT FK, 1:Many)
    │
    └─► KnowledgeRelations
        ├─► fromEntryId (TEXT FK)
        └─► toEntryId (TEXT FK)
```

### Cascade Behavior

**ON DELETE CASCADE:**
- EntryTags: Delete tag associations when entry deleted
- EntryMetadata: Delete metadata when entry deleted
- KnowledgeAttachments: Delete attachment records (files remain for manual cleanup)
- KnowledgeHistory: Retain history even when entry deleted (soft delete recommended)
- KnowledgeRelations: Delete relationships when either entry deleted

**ON UPDATE CASCADE:**
- All foreign keys update if entry ID changes (rare, discouraged)

---

## Indexes

### Performance Indexes

```sql
-- Category lookups
CREATE INDEX idx_entries_category_id ON knowledge_entries(category_id);

-- Equipment filtering
CREATE INDEX idx_entries_equipment ON knowledge_entries(equipment_type, manufacturer);

-- Status and workflow
CREATE INDEX idx_entries_review_status ON knowledge_entries(review_status);
CREATE INDEX idx_entries_status ON knowledge_entries(status);

-- Date-based queries
CREATE INDEX idx_entries_updated ON knowledge_entries(updated_at DESC);
CREATE INDEX idx_entries_published ON knowledge_entries(published_at DESC);

-- Analytics
CREATE INDEX idx_metadata_viewed ON entry_metadata(last_viewed_at DESC);
CREATE INDEX idx_metadata_helpful ON entry_metadata(helpful_count DESC);

-- Tags
CREATE INDEX idx_entry_tags_entry ON entry_tags(entry_id);
CREATE INDEX idx_entry_tags_tag ON entry_tags(tag_id);

-- Categories hierarchy
CREATE INDEX idx_categories_parent ON knowledge_categories(parent_id);
CREATE INDEX idx_categories_level ON knowledge_categories(level);

-- Attachments
CREATE INDEX idx_attachments_entry ON knowledge_attachments(entry_id);
```

---

## Triggers

### FTS5 Sync Triggers

**Insert Trigger:**
```sql
CREATE TRIGGER knowledge_fts_insert AFTER INSERT ON knowledge_entries
BEGIN
  INSERT INTO knowledge_fts(
    rowid, title, content, summary, category, 
    equipment_type, manufacturer, symptoms, tags
  )
  VALUES (
    new.rowid,
    new.title,
    new.content,
    new.summary,
    new.category,
    new.equipment_type,
    new.manufacturer,
    new.symptoms,
    (SELECT group_concat(kt.name, ' ') FROM entry_tags et 
     JOIN knowledge_tags kt ON et.tag_id = kt.id 
     WHERE et.entry_id = new.id)
  );
END;
```

**Update Trigger:**
```sql
CREATE TRIGGER knowledge_fts_update AFTER UPDATE ON knowledge_entries
BEGIN
  UPDATE knowledge_fts 
  SET 
    title = new.title,
    content = new.content,
    summary = new.summary,
    category = new.category,
    equipment_type = new.equipment_type,
    manufacturer = new.manufacturer,
    symptoms = new.symptoms,
    tags = (SELECT group_concat(kt.name, ' ') FROM entry_tags et 
            JOIN knowledge_tags kt ON et.tag_id = kt.id 
            WHERE et.entry_id = new.id)
  WHERE rowid = new.rowid;
END;
```

**Delete Trigger:**
```sql
CREATE TRIGGER knowledge_fts_delete AFTER DELETE ON knowledge_entries
BEGIN
  DELETE FROM knowledge_fts WHERE rowid = old.rowid;
END;
```

### Audit Trail Triggers

**Insert Audit:**
```sql
CREATE TRIGGER knowledge_history_insert AFTER INSERT ON knowledge_entries
BEGIN
  INSERT INTO knowledge_history(
    entry_id, change_type, changed_by, changed_at, version_after
  ) VALUES (
    new.id, 'created', new.author, datetime('now'), new.version
  );
END;
```

**Update Audit:**
```sql
CREATE TRIGGER knowledge_history_update AFTER UPDATE ON knowledge_entries
WHEN old.title != new.title 
  OR old.content != new.content 
  OR old.version != new.version
BEGIN
  INSERT INTO knowledge_history(
    entry_id, change_type, changed_by, changed_at,
    version_before, version_after, change_notes
  ) VALUES (
    new.id, 'updated', new.author, datetime('now'),
    old.version, new.version, new.change_notes
  );
END;
```

### Category Count Maintenance

**Increment on Entry Create:**
```sql
CREATE TRIGGER category_count_inc AFTER INSERT ON knowledge_entries
WHEN new.category_id IS NOT NULL
BEGIN
  UPDATE knowledge_categories 
  SET article_count = article_count + 1
  WHERE id = new.category_id;
END;
```

**Decrement on Entry Delete:**
```sql
CREATE TRIGGER category_count_dec AFTER DELETE ON knowledge_entries
WHEN old.category_id IS NOT NULL
BEGIN
  UPDATE knowledge_categories 
  SET article_count = article_count - 1
  WHERE id = old.category_id;
END;
```

---

## Migration Guide

### Step 1: Backup Current Database

```bash
# Backup existing database
cp "%AppData%/portal_offline.sqlite" "%AppData%/portal_offline_backup_$(date).sqlite"
```

### Step 2: Add New Tables

Execute in order:
1. CREATE TABLE knowledge_categories
2. CREATE TABLE knowledge_tags
3. CREATE TABLE entry_tags
4. CREATE TABLE knowledge_attachments
5. CREATE TABLE knowledge_history
6. CREATE TABLE knowledge_relations
7. CREATE TABLE entry_metadata

### Step 3: Alter KnowledgeEntries

```sql
-- Add new columns with defaults
ALTER TABLE knowledge_entries ADD COLUMN summary TEXT DEFAULT '';
ALTER TABLE knowledge_entries ADD COLUMN category_id INTEGER;
ALTER TABLE knowledge_entries ADD COLUMN manufacturer TEXT;
ALTER TABLE knowledge_entries ADD COLUMN applicable_models TEXT;
ALTER TABLE knowledge_entries ADD COLUMN service_type TEXT DEFAULT 'reference';
ALTER TABLE knowledge_entries ADD COLUMN difficulty_level TEXT DEFAULT 'intermediate';
ALTER TABLE knowledge_entries ADD COLUMN priority_level TEXT DEFAULT 'standard';
ALTER TABLE knowledge_entries ADD COLUMN safety_level TEXT DEFAULT 'none';
ALTER TABLE knowledge_entries ADD COLUMN compliance_tags TEXT;
ALTER TABLE knowledge_entries ADD COLUMN estimated_time_minutes INTEGER;
ALTER TABLE knowledge_entries ADD COLUMN required_tools TEXT;
ALTER TABLE knowledge_entries ADD COLUMN required_parts TEXT;
ALTER TABLE knowledge_entries ADD COLUMN prerequisites TEXT;
ALTER TABLE knowledge_entries ADD COLUMN special_requirements TEXT;
ALTER TABLE knowledge_entries ADD COLUMN symptoms TEXT;
ALTER TABLE knowledge_entries ADD COLUMN solutions_count INTEGER DEFAULT 1;
ALTER TABLE knowledge_entries ADD COLUMN has_images BOOLEAN DEFAULT 0;
ALTER TABLE knowledge_entries ADD COLUMN has_attachments BOOLEAN DEFAULT 0;
ALTER TABLE knowledge_entries ADD COLUMN author TEXT;
ALTER TABLE knowledge_entries ADD COLUMN author_role TEXT;
ALTER TABLE knowledge_entries ADD COLUMN reviewer TEXT;
ALTER TABLE knowledge_entries ADD COLUMN reviewed_at DATETIME;
ALTER TABLE knowledge_entries ADD COLUMN review_status TEXT DEFAULT 'draft';
ALTER TABLE knowledge_entries ADD COLUMN approval_required BOOLEAN DEFAULT 0;
ALTER TABLE knowledge_entries ADD COLUMN change_notes TEXT;
ALTER TABLE knowledge_entries ADD COLUMN external_id TEXT;
ALTER TABLE knowledge_entries ADD COLUMN last_synced_at DATETIME;
ALTER TABLE knowledge_entries ADD COLUMN sync_source TEXT;
ALTER TABLE knowledge_entries ADD COLUMN published_at DATETIME;
ALTER TABLE knowledge_entries ADD COLUMN archived_at DATETIME;
```

### Step 4: Create FTS5 Virtual Table

```sql
CREATE VIRTUAL TABLE knowledge_fts USING fts5(
  title,
  content,
  summary,
  category,
  equipment_type,
  manufacturer,
  symptoms,
  tags,
  tokenize='porter unicode61 remove_diacritics 1',
  prefix='2 3 4',
  content='knowledge_entries',
  content_rowid='rowid'
);
```

### Step 5: Populate FTS5 from Existing Data

```sql
INSERT INTO knowledge_fts(rowid, title, content, summary, category, equipment_type, manufacturer, symptoms, tags)
SELECT 
  rowid,
  title,
  content,
  SUBSTR(content, 1, 200) as summary,
  category,
  equipment_type,
  COALESCE(manufacturer, '') as manufacturer,
  COALESCE(symptoms, '') as symptoms,
  '' as tags
FROM knowledge_entries;
```

### Step 6: Create Triggers

Execute all FTS5 sync triggers and audit trail triggers.

### Step 7: Seed Category Hierarchy

Run category seed script (to be created).

### Step 8: Migrate Existing Entries

```sql
-- Populate summary from content
UPDATE knowledge_entries 
SET summary = SUBSTR(content, 1, 200)
WHERE summary = '';

-- Set default review status for existing approved entries
UPDATE knowledge_entries 
SET review_status = 'published'
WHERE status = 'active';

-- Create metadata records for all entries
INSERT INTO entry_metadata(entry_id)
SELECT id FROM knowledge_entries
WHERE NOT EXISTS (SELECT 1 FROM entry_metadata WHERE entry_id = knowledge_entries.id);
```

### Step 9: Create Indexes

Execute all index creation statements.

### Step 10: Verify Migration

```sql
-- Check counts match
SELECT COUNT(*) FROM knowledge_entries;
SELECT COUNT(*) FROM knowledge_fts;
SELECT COUNT(*) FROM entry_metadata;

-- Test FTS5 search
SELECT * FROM knowledge_fts WHERE knowledge_fts MATCH 'atm error' LIMIT 5;

-- Verify categories
SELECT * FROM knowledge_categories WHERE parent_id IS NULL;
```

---

## Query Examples

### Basic FTS5 Search with Ranking

```sql
SELECT 
  ke.*,
  bm25(kf) as relevance_score,
  snippet(kf, 1, '<mark>', '</mark>', '...', 32) as content_snippet,
  highlight(kf, 0, '<mark>', '</mark>') as highlighted_title
FROM knowledge_entries ke
JOIN knowledge_fts kf ON ke.rowid = kf.rowid
WHERE kf MATCH 'atm card reader error'
ORDER BY bm25(kf) ASC
LIMIT 50;
```

### Advanced Search with Filters

```sql
SELECT ke.*, bm25(kf) as score
FROM knowledge_entries ke
JOIN knowledge_fts kf ON ke.rowid = kf.rowid
WHERE kf MATCH 'repair jam'
  AND ke.equipment_type = 'Coin Sorter'
  AND ke.difficulty_level IN ('beginner', 'intermediate')
  AND ke.safety_level IN ('none', 'caution')
ORDER BY bm25(kf) ASC;
```

### Hierarchical Category Query

```sql
-- Get category with breadcrumb
WITH RECURSIVE category_path AS (
  SELECT id, name, parent_id, level, name as path
  FROM knowledge_categories
  WHERE id = ?
  
  UNION ALL
  
  SELECT c.id, c.name, c.parent_id, c.level, c.name || ' > ' || cp.path
  FROM knowledge_categories c
  JOIN category_path cp ON c.id = cp.parent_id
)
SELECT path FROM category_path 
WHERE parent_id IS NULL;
```

### Popular Articles Query

```sql
SELECT ke.*, em.view_count, em.helpful_count
FROM knowledge_entries ke
JOIN entry_metadata em ON ke.id = em.entry_id
WHERE ke.status = 'active'
  AND ke.review_status = 'published'
ORDER BY em.view_count DESC
LIMIT 10;
```

### Articles Needing Review

```sql
SELECT ke.*, 
  JULIANDAY('now') - JULIANDAY(ke.reviewed_at) as days_since_review
FROM knowledge_entries ke
WHERE ke.review_status = 'published'
  AND (
    ke.reviewed_at IS NULL 
    OR JULIANDAY('now') - JULIANDAY(ke.reviewed_at) > 180
  )
ORDER BY days_since_review DESC;
```

---

## Data Integrity Constraints

### Required Fields

- id (must be unique, non-null)
- title (non-null)
- content (non-null)
- equipment_type (non-null)
- category (non-null for backward compatibility)

### Optional but Recommended

- manufacturer (helps with filtering)
- summary (improves search results)
- author (for accountability)
- reviewer (for quality control)
- estimated_time_minutes (helps technicians plan)
- required_tools (ensures technicians are prepared)

### Validation Rules (Application Layer)

1. **ID Format:** Lowercase, alphanumeric + hyphens only
2. **Version Format:** Semantic versioning (X.Y.Z)
3. **Difficulty Levels:** beginner, intermediate, advanced, expert only
4. **Safety Levels:** none, caution, warning, danger only
5. **Service Types:** maintenance, troubleshooting, installation, reference, safety
6. **Review Status:** draft, pending_review, changes_requested, approved, published, archived
7. **JSON Fields:** Valid JSON for arrays (tools, parts, compliance_tags, applicable_models)

---

## Performance Considerations

### FTS5 Optimization

**Automerge Configuration:**
```sql
INSERT INTO knowledge_fts(knowledge_fts, rank) VALUES('automerge', 8);
INSERT INTO knowledge_fts(knowledge_fts, rank) VALUES('crisismerge', 16);
```

**Manual Optimization (run monthly):**
```sql
INSERT INTO knowledge_fts(knowledge_fts) VALUES('optimize');
```

**Integrity Check:**
```sql
INSERT INTO knowledge_fts(knowledge_fts) VALUES('integrity-check');
```

### Query Performance

**Expected Performance (10,000 articles):**
- FTS5 search: <100ms
- Category navigation: <50ms
- Article load: <20ms
- Autocomplete: <50ms

**Optimization Strategies:**
- Limit FTS5 results to 100 max
- Implement pagination (50 results per page)
- Cache category hierarchy (rarely changes)
- Lazy-load attachments
- Index frequently queried columns

---

## Storage Estimates

**Per Article (Average):**
- Metadata: ~2 KB
- Content: ~10 KB (5-page article)
- FTS5 index: ~15 KB
- Total: ~27 KB per article

**10,000 Articles:**
- Main tables: ~270 MB
- Indexes: ~50 MB
- Attachments: Variable (1-10 GB typical)
- **Total Database: ~320 MB**

**Attachment Storage:**
- Images: ~100-500 KB each
- PDFs: ~1-5 MB each
- Recommended limit: 10 attachments per article

---

**End of Knowledge Base Schema Documentation**
