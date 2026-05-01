# Knowledge Base Search Guide

**Version:** 1.0  
**Last Updated:** January 31, 2026  
**Purpose:** User guide for search functionality and syntax

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [Search Syntax](#search-syntax)
3. [Advanced Filters](#advanced-filters)
4. [Search Tips](#search-tips)
5. [Examples](#examples)

---

## Quick Start

### Basic Search

Simply type keywords into the search box:

```
atm error
```

**Results:**
- Articles containing both "atm" AND "error"
- Ranked by relevance (most relevant first)
- Highlighted matches in title and snippet

### Autocomplete

Start typing (minimum 2 characters) to see suggestions:

```
card re...
```

**Suggestions:**
- Card Reader Replacement
- Card Reader Error Codes
- Card Reader Calibration

---

## Search Syntax

The knowledge base uses **SQLite FTS5** for powerful full-text search.

### Boolean Operators

**AND (default):**
```
atm error code
```
Finds articles containing all three words.

**OR:**
```
hyosung OR ncr
```
Finds articles containing either word.

**NOT:**
```
atm NOT hyosung
```
Finds articles about ATMs but not Hyosung models.

**Combining operators:**
```
(hyosung OR ncr) AND error
```
Finds error-related articles for either manufacturer.

### Phrase Matching

Use quotes for exact phrases:

```
"card reader malfunction"
```

Finds only articles with that exact phrase.

### Proximity Search

Find words near each other using NEAR:

```
error NEAR/5 code
```

Finds "error" and "code" within 5 words of each other.

**Examples:**
- `card NEAR/3 reader` - Matches "card reader", "reader card", "card slot reader"
- `jam NEAR/10 clear` - Finds jam-clearing procedures

### Prefix Matching

Use asterisk for prefix matching:

```
calibr*
```

Matches: calibrate, calibration, calibrating, calibrator

**Useful for:**
- Finding variations of a word
- Autocomplete-style searches
- Uncertain spelling

### Column Filtering

Search specific fields:

```
title:error
```

Searches only in article titles.

**Available fields:**
- `title:keyword` - Search titles only
- `content:keyword` - Search content only
- `category:keyword` - Search categories
- `equipment_type:keyword` - Search equipment types
- `manufacturer:keyword` - Search manufacturers

**Example:**
```
title:hyosung content:error
```
Finds articles with "hyosung" in title and "error" in content.

---

## Advanced Filters

### Equipment Filter

Limit results to specific equipment type:

**UI:** Select from "Equipment" dropdown  
**Effect:** Only shows articles for selected equipment

**Use case:** When you know the equipment type but not the specific issue

### Category Filter

Limit to specific service category:

**UI:** Select from "Category" dropdown  
**Effect:** Only shows articles in that category

**Use case:** Browse all troubleshooting guides, all maintenance procedures, etc.

### Difficulty Filter

Filter by skill level:

- **Beginner:** Basic tasks, no special training
- **Intermediate:** Standard technical work
- **Advanced:** Specialized procedures
- **Expert:** Requires certification/extensive experience

**Use case:** New technicians filter for beginner-friendly articles

### Safety Level Filter

Filter by safety requirements:

- **None:** Standard safety
- **Caution:** Exercise care
- **Warning:** Significant hazards
- **Danger:** High-risk, qualified personnel only

**Use case:** Filter out high-risk procedures if not qualified

### Time Estimate Filter

(Future feature)

Filter articles by estimated time:
- Under 15 minutes
- 15-30 minutes
- 30-60 minutes
- Over 1 hour

**Use case:** Find quick fixes when time is limited

---

## Search Tips

### Finding Specific Error Codes

Search the exact error code:

```
E-0042
```

Or combine with equipment:

```
hyosung E-0042
```

### Finding Quick Fixes

Use these searches:

```
title:"quick" OR quick-fix
```

Or filter by difficulty: **Beginner**

### Finding Procedures for Specific Equipment

```
equipment_type:"ATM / TCR" manufacturer:hyosung
```

Or use equipment filter in UI.

### Finding Recently Updated Articles

(Coming soon - UI feature)

Sort by update date to find newest content.

### Finding Popular Articles

(Coming soon - UI feature)

Sort by view count or helpful votes.

---

## Examples

### Example 1: Troubleshooting ATM Card Reader

**Goal:** Find articles about ATM card reader problems

**Search:**
```
atm card reader error
```

**Better search:**
```
(atm OR tcr) AND "card reader" AND (error OR malfunction OR jam)
```

**With filters:**
- Equipment: ATM / TCR
- Category: Troubleshooting
- Difficulty: All

**Expected results:**
- Card Reader Error Code Guide
- How to Clear Card Reader Jams
- Card Reader Diagnostic Procedures

---

### Example 2: Daily Maintenance Checklist

**Goal:** Find daily maintenance procedures

**Search:**
```
daily maintenance checklist
```

**With filters:**
- Category: Maintenance > Preventive > Daily
- Difficulty: Beginner

**Expected results:**
- Daily ATM Inspection Checklist
- Morning Equipment Checks
- Daily Cash Dispenser Verification

---

### Example 3: Hyosung MX8600 Specific

**Goal:** All documentation for specific model

**Search:**
```
manufacturer:hyosung AND (MX8600 OR MX-8600)
```

**With filters:**
- Equipment: ATM / TCR > Hyosung

**Expected results:**
- All articles specific to Hyosung MX8600
- Organized by service type
- Includes troubleshooting, maintenance, and reference

---

### Example 4: Safety-Critical Procedures

**Goal:** Find procedures requiring LOTO

**Search:**
```
lockout tagout OR LOTO
```

**With filters:**
- Safety: Warning or Danger

**Expected results:**
- Procedures requiring lockout/tagout
- High-voltage work procedures
- Confined space entry procedures

---

### Example 5: Quick Reference

**Goal:** Find part number quickly

**Search:**
```
"CR-CLEAN-001"
```

Or:

```
category:reference card reader cleaning
```

**Expected results:**
- Parts catalog entries
- Replacement part specifications

---

## Search Best Practices

### Do:

- **Start simple** - Try basic keywords first
- **Use autocomplete** - Let suggestions guide you
- **Combine keywords** - More keywords = more specific results
- **Use filters** - Narrow results when you get too many
- **Try variations** - Different technicians may use different terms

### Don't:

- **Don't use full sentences** - Keywords work better than questions
- **Don't over-specify** - Too many filters = no results
- **Don't ignore suggestions** - Autocomplete shows real articles
- **Don't give up** - Try synonyms or related terms

### Common Search Patterns

**Problem diagnosis:**
```
[equipment] [symptom] [error/issue]
Example: atm card jam
```

**Part identification:**
```
[equipment] [component] part number
Example: hyosung card reader part number
```

**Procedure lookup:**
```
[task] [equipment] [procedure type]
Example: install replacement coin sorter motor
```

**General information:**
```
[equipment] [topic] guide/manual/reference
Example: ncr atm error code reference
```

---

## Understanding Results

### Result Card Information

Each search result shows:

**Title** (highlighted matches in bold)  
**Category** • Equipment Type  
**Difficulty Level** (beginner/intermediate/advanced/expert)  
**Time Estimate** (if available)  
**Safety Level** (if above "none")  
**Content Snippet** (excerpt with highlighted matches)  
**Metadata:** Views, helpful votes, last updated

### Relevance Ranking

Results are ranked using **BM25 algorithm**:
- Matches in title ranked higher than in content
- Rare terms ranked higher than common terms
- Shorter articles with more matches ranked higher

**Why is this result first?**
- Exact title match
- Multiple keyword matches
- High helpful vote count
- Recent update

---

## Troubleshooting Search

### "No results found"

**Try:**
1. Check spelling
2. Use fewer keywords
3. Try synonyms (e.g., "fix" instead of "repair")
4. Remove filters
5. Use broader terms (e.g., "atm" instead of "hyosung mx8600")

### Too many results

**Try:**
1. Add more specific keywords
2. Use equipment filter
3. Use category filter
4. Use phrase matching with quotes
5. Use column filters (title:, content:)

### Wrong results

**Try:**
1. Use more specific equipment terms
2. Add manufacturer name
3. Use NOT operator to exclude unwanted results
4. Use phrase matching for exact terms
5. Check filters aren't too restrictive

---

## Keyboard Shortcuts

(Future feature)

- **Ctrl+K** - Focus search box
- **Esc** - Clear search
- **Enter** - Search
- **Arrow keys** - Navigate suggestions
- **Tab** - Accept suggestion

---

**End of Search Guide**
