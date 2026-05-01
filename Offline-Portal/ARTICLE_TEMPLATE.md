# Knowledge Base Article Template

**Version:** 1.0  
**Last Updated:** January 31, 2026  
**Purpose:** Standard template for creating knowledge base articles

---

## Copy This Template

```markdown
---
# ============================================
# REQUIRED METADATA
# ============================================
id: unique-article-id-lowercase-with-hyphens
title: "Clear, Descriptive Title of Procedure or Topic"
version: "1.0.0"
status: "active"

# ============================================
# TAXONOMY & CLASSIFICATION
# ============================================
category: "Troubleshooting"
equipment_type: "ATM / TCR"
manufacturer: "Hyosung"
equipment_model: "MX8600"
applicable_models: ["MX8600", "MX8600T", "MX8600R"]

# ============================================
# SERVICE CLASSIFICATION
# ============================================
service_type: "troubleshooting"
# Options: maintenance, troubleshooting, installation, reference, safety

difficulty_level: "intermediate"
# Options: beginner, intermediate, advanced, expert

priority_level: "high"
# Options: critical, high, standard, low

safety_level: "caution"
# Options: none, caution, warning, danger

compliance_tags: ["manufacturer_warranty", "OSHA"]
# Options: OSHA, ISO9001, manufacturer_warranty, EPA, etc.

# ============================================
# PROCEDURE DETAILS
# ============================================
estimated_time_minutes: 20
required_tools: ["Phillips screwdriver #2", "Digital multimeter", "Cleaning kit"]
required_parts: ["Card reader cleaning card (CR-CLEAN-001)"]
prerequisites: "atm-basic-access,electrical-safety-training"
special_requirements: "Requires supervisor approval for warranty equipment"

# ============================================
# CONTENT METADATA
# ============================================
symptoms: "Card reader not reading, Error code E-0042, Card jams"
solutions_count: 3

# ============================================
# AUTHORING & QUALITY
# ============================================
author: "John Smith"
author_role: "Senior Field Technician"
reviewer: "Jane Doe"
reviewed_at: "2026-01-15"
review_status: "published"
# Options: draft, pending_review, changes_requested, approved, published, archived

# ============================================
# SOURCE TRACKING
# ============================================
source_type: "manual_import"
source_file: "hyosung_mx8600_troubleshooting.pdf"
external_id: "HYOSUNG-KB-0042"
---

# Article Title (H1 - Should match title in metadata)

## Overview

Brief overview of the topic, issue, or procedure. Explain what this article covers and when to use it.

**Applicability:** This procedure applies to [list equipment models or situations].

## Safety Warnings

⚠️ **[SAFETY LEVEL]**: [Specific safety warning]

- Disconnect power before accessing internal components
- Follow lockout/tagout procedures per OSHA guidelines
- Wear appropriate PPE (list specific PPE)
- [Additional safety considerations]

## Required Tools & Parts

**Tools:**
- Tool 1 with specification
- Tool 2 with specification
- Tool 3 with specification

**Parts:**
- Part name (part number: XXX-YYYY-ZZZ)
- Replacement component (part number: XXX-YYYY-ZZZ)

**Consumables:**
- Cleaning supplies
- Lubricants
- etc.

## Prerequisites

Before starting this procedure, ensure you have:
- [ ] Completed required safety training
- [ ] Read prerequisite articles (link to articles)
- [ ] Obtained necessary approvals
- [ ] Equipment is powered down and locked out

## Symptoms (For Troubleshooting Articles)

This issue typically manifests as:
- Symptom 1: Description of what user sees/experiences
- Symptom 2: Specific error messages or codes
- Symptom 3: Observable behavior

**Related Error Codes:** E-XXXX, E-YYYY

## Diagnostic Procedure (For Troubleshooting)

### Step 1: Initial Assessment

1. Verify the reported symptoms
2. Check error logs for codes
3. Note any recent changes or events

### Step 2: Visual Inspection

1. Open equipment panel using service key
2. Locate affected component (provide location details)
3. Check for:
   - Physical damage
   - Loose connections
   - Foreign objects
   - Wear or corrosion

### Step 3: Component Testing

1. Access diagnostic mode:
   ```bash
   MENU > DIAGNOSTICS > COMPONENT_TEST
   ```
2. Run specific diagnostic test
3. Interpret results:
   - PASS: Component functioning correctly
   - FAIL: Proceed to resolution steps

## Resolution Procedure

### Solution 1: [Most Common Fix]

1. Detailed step-by-step instructions
2. Include specific button presses, menu navigation
3. Provide expected outcomes at each step

**Expected Result:** [What should happen]

### Solution 2: [Alternative Fix]

1. When to use this solution
2. Step-by-step instructions
3. Expected outcomes

### Solution 3: [Escalation Path]

If previous solutions don't resolve the issue:
1. Document all steps attempted
2. Note error codes and symptoms
3. Contact [escalation contact/supervisor]
4. Prepare for potential component replacement

## Verification

After completing the procedure:
1. [ ] Run full diagnostic test
2. [ ] Verify issue is resolved
3. [ ] Test with multiple cycles/transactions
4. [ ] Clear error log
5. [ ] Update maintenance record
6. [ ] Document resolution in work order

## Configuration Settings (If Applicable)

Settings modified during this procedure:

| Setting | Original Value | New Value | Purpose |
|---------|---------------|-----------|---------|
| Setting 1 | Default | Modified | Reason |
| Setting 2 | Default | Modified | Reason |

## Troubleshooting

**If the issue persists:**
- Check [related component/system]
- Verify [specific condition]
- Review [related article]

**Common mistakes:**
- Mistake 1 and how to avoid it
- Mistake 2 and how to avoid it

## Maintenance Notes

- Recommended frequency: [Daily/Weekly/Monthly]
- Record keeping requirements
- Next scheduled service date calculation

## Related Articles

- [Article Title 1](entry-id-1) - Brief description
- [Article Title 2](entry-id-2) - Brief description
- [Article Title 3](entry-id-3) - Brief description

## Additional Resources

- Manufacturer manual: [Reference]
- Technical bulletin: [Reference]
- Video guide: [Link if available]

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | 2026-01-01 | J. Smith | Initial creation |
| 1.1.0 | 2026-01-10 | J. Smith | Added alternative solution |
| 2.0.0 | 2026-01-15 | J. Doe | Reviewed and approved |

---

**Document ID:** EQUIPMENT-KB-XXXX  
**Last Reviewed:** January 15, 2026  
**Next Review Due:** July 15, 2026  
**Review Responsibility:** Technical Documentation Team
```

---

## Metadata Field Descriptions

### Required Metadata

**id:**
- Unique identifier (lowercase, alphanumeric + hyphens only)
- Example: `hyosung-atm-error-e0042`

**title:**
- Clear, descriptive title (proper case)
- Should answer "what is this about?"
- Example: "How to Clear Error Code E-0042 on Hyosung ATM"

**version:**
- Semantic versioning (MAJOR.MINOR.PATCH)
- Increment MAJOR for significant changes
- Increment MINOR for additions
- Increment PATCH for corrections
- Example: "2.1.3"

**status:**
- Article lifecycle status
- Values: `active`, `inactive`, `deprecated`
- Use `active` for published articles

### Taxonomy Fields

**category:**
- Primary functional category
- Examples: "Troubleshooting", "Maintenance", "Installation", "Reference"

**equipment_type:**
- Type of equipment this article covers
- Examples: "ATM / TCR", "Coin Sorter", "Currency Counter", "Surveillance"

**manufacturer:**
- Equipment manufacturer
- Examples: "Hyosung", "NCR", "Diebold", "JetSort"

**equipment_model:**
- Specific model if applicable
- Example: "MX8600"

**applicable_models:**
- YAML array of all models this applies to
- Example: `["MX8600", "MX8600T", "MX8600R"]`

### Classification Fields

**service_type:**
- Type of service procedure
- Values: `maintenance`, `troubleshooting`, `installation`, `reference`, `safety`

**difficulty_level:**
- Technical skill level required
- Values: `beginner`, `intermediate`, `advanced`, `expert`
- Helps technicians self-select appropriate articles

**priority_level:**
- Urgency/importance of the procedure
- Values: `critical`, `high`, `standard`, `low`
- Critical: Service-affecting issues
- High: Important but not service-affecting
- Standard: Routine procedures
- Low: Nice-to-know information

**safety_level:**
- Safety considerations
- Values: `none`, `caution`, `warning`, `danger`
- none: Standard safety applies
- caution: Exercise care
- warning: Significant hazards present
- danger: High-risk procedure, qualified personnel only

**compliance_tags:**
- Regulatory or compliance requirements
- YAML array: `["OSHA", "ISO9001", "manufacturer_warranty"]`

### Procedure Metadata

**estimated_time_minutes:**
- Typical time to complete procedure
- Integer value (minutes)
- Helps technicians schedule work

**required_tools:**
- YAML array of tools needed
- Include specifications: `["Phillips screwdriver #2", "Digital multimeter"]`

**required_parts:**
- YAML array of parts needed
- Include part numbers: `["Cleaning card (CR-CLEAN-001)"]`

**prerequisites:**
- Comma-separated list of prerequisite article IDs
- Example: `"atm-basic-access,electrical-safety-training"`

**special_requirements:**
- Any special conditions or approvals needed
- Example: "Requires supervisor approval for warranty equipment"

### Content Metadata

**symptoms:**
- For troubleshooting articles
- Comma-separated list of observable symptoms
- Example: "Card reader not reading, Error code E-0042, Card jams"

**solutions_count:**
- Number of distinct solutions provided
- Integer value
- Helps set user expectations

### Authoring Fields

**author:**
- Name of content author
- Example: "John Smith"

**author_role:**
- Author's job title or role
- Example: "Senior Field Technician"

**reviewer:**
- Name of technical reviewer
- Example: "Jane Doe"

**reviewed_at:**
- Date of last review (YYYY-MM-DD format)
- Example: "2026-01-15"

**review_status:**
- Current approval state
- Values: `draft`, `pending_review`, `changes_requested`, `approved`, `published`, `archived`

### Source Fields

**source_type:**
- Origin of the content
- Values: `manual_import`, `api_sync`, `file_system`, `manual_entry`

**source_file:**
- Original filename or document reference
- Example: "hyosung_mx8600_manual.pdf"

**external_id:**
- External system identifier (if syncing with other systems)
- Example: "HYOSUNG-KB-0042"

---

## Content Structure Guidelines

### Article Title (H1)

- Use one H1 heading (the article title)
- Should match the `title` in metadata
- Clear, action-oriented language
- Examples:
  - "How to Clear Error Code E-0042"
  - "Daily Preventive Maintenance Checklist"
  - "Installing a Replacement Card Reader"

### Section Headings (H2)

Use consistent section headings for easy navigation:
- **Overview** - Brief summary
- **Safety Warnings** - Critical safety info (always include if safety_level > none)
- **Required Tools & Parts** - What technician needs
- **Prerequisites** - What must be done first
- **Symptoms** - Observable issues (troubleshooting)
- **Diagnostic Procedure** - How to diagnose (troubleshooting)
- **Resolution Procedure** - Step-by-step fix
- **Verification** - How to confirm success
- **Configuration Settings** - Settings modified
- **Troubleshooting** - What if it doesn't work
- **Maintenance Notes** - Ongoing care
- **Related Articles** - Links to related content
- **Revision History** - Change log

### Subsection Headings (H3)

- Use for multi-step procedures
- Example: "Step 1: Visual Inspection"

### Lists

**Bullet lists** for:
- Symptoms
- Tools/parts
- Checklists
- Related items

**Numbered lists** for:
- Sequential procedures
- Step-by-step instructions
- Multi-stage processes

**Checklists** (- [ ]) for:
- Prerequisites
- Verification steps
- Quality checks

### Code Blocks

Use triple backticks with language identifier:

````markdown
```bash
# Command to execute
MENU > DIAGNOSTICS > TEST_MODE
```
````

### Tables

Use for:
- Configuration settings
- Part numbers
- Error code mappings
- Revision history

### Emphasis

- **Bold** for important terms, warnings, part numbers
- *Italic* for notes, asides, cross-references
- `Code` for error codes, menu paths, commands

---

## Quality Checklist

Before submitting an article, verify:

### Content Quality
- [ ] Title is clear and descriptive
- [ ] Overview explains purpose and applicability
- [ ] Safety warnings are prominent (if applicable)
- [ ] Steps are numbered and sequential
- [ ] Expected outcomes are stated
- [ ] Verification steps included
- [ ] Related articles linked

### Metadata Completeness
- [ ] All required fields populated
- [ ] Difficulty level accurate
- [ ] Time estimate realistic
- [ ] Tools and parts listed completely
- [ ] Safety level appropriate
- [ ] Category and equipment type correct

### Technical Accuracy
- [ ] Procedure tested on actual equipment
- [ ] Error codes verified
- [ ] Part numbers confirmed
- [ ] Screenshots/diagrams accurate (if included)
- [ ] Reviewed by senior technician

### Formatting
- [ ] One H1 heading (title)
- [ ] H2 sections used consistently
- [ ] Lists formatted properly
- [ ] Code blocks have language tags
- [ ] Tables render correctly
- [ ] No spelling errors

---

## Example Articles

### Example 1: Troubleshooting Article

See: `hyosung-atm-card-reader-error-e0042.md` (in staging directory)

Key features:
- Clear symptom description
- Diagnostic flowchart
- Multiple solution paths
- Escalation procedures
- Verification steps

### Example 2: Maintenance Procedure

See: `preventive-maintenance-atm-daily.md`

Key features:
- Checklist format
- Time-based organization
- Clear pass/fail criteria
- Documentation requirements

### Example 3: Installation Guide

See: `install-replacement-card-reader.md`

Key features:
- Parts list with images
- Tool requirements
- Sequential steps with diagrams
- Configuration settings
- Testing procedure

---

## Submission Process

1. **Create Draft**
   - Use this template
   - Fill all required metadata
   - Write content following guidelines

2. **Self-Review**
   - Run through quality checklist
   - Test procedure if possible
   - Fix any issues found

3. **Submit for Review**
   - Set `review_status: pending_review`
   - Assign to reviewer
   - Include change notes if updating existing article

4. **Technical Review**
   - Reviewer validates technical accuracy
   - Checks completeness
   - Suggests improvements

5. **Approval**
   - Set `review_status: approved`
   - Reviewer signs off
   - Set review date

6. **Publication**
   - Set `status: active`
   - Set `review_status: published`
   - Import into knowledge base
   - Notify team of new/updated article

---

## Revision Guidelines

When updating an existing article:

1. Increment version number appropriately
2. Add entry to Revision History table
3. Include `change_notes` in metadata
4. Re-submit for review if significant changes
5. Update `reviewed_at` date

### Version Incrementing

- **Major (X.0.0):** Complete rewrite, fundamental changes
- **Minor (1.X.0):** New sections, additional solutions, substantial additions
- **Patch (1.0.X):** Corrections, clarifications, minor updates

---

**End of Template Documentation**
