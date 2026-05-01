# Knowledge Base Taxonomy Guide

**Version:** 1.0  
**Last Updated:** January 31, 2026  
**Purpose:** Complete guide to the hierarchical category system and classification schema

---

## Table of Contents

1. [Taxonomy Overview](#taxonomy-overview)
2. [Equipment Hierarchy](#equipment-hierarchy)
3. [Service Procedure Hierarchy](#service-procedure-hierarchy)
4. [Classification Guidelines](#classification-guidelines)
5. [Tagging Strategy](#tagging-strategy)

---

## Taxonomy Overview

### Three-Level Hierarchy

The FSC Portal knowledge base uses a **three-level hierarchical taxonomy**:

```
LEVEL 1: Domain
    ├─ LEVEL 2: Type/Category
    │   └─ LEVEL 3: Specific Variant
```

**Benefits:**
- Intuitive navigation for field technicians
- Clear organization by equipment and service type
- Scalable to thousands of articles
- Supports both equipment-based and task-based browsing

### Dual Taxonomy System

Articles can be classified using **two complementary hierarchies**:

1. **Equipment-Based:** Organized by what equipment is involved
2. **Service-Based:** Organized by what type of work is being done

**Example Article:**
- Equipment path: Cash Handling > ATM/TCR > Hyosung
- Service path: Troubleshooting > Error Code Resolution

---

## Equipment Hierarchy

### Level 1: Equipment Domains

Four primary equipment domains:

#### 1. Cash Handling Equipment
**Slug:** `cash-handling`  
**Icon:** account_balance  
**Color:** #0056D2 (Blue)

**Description:** All equipment related to cash processing, dispensing, sorting, and counting.

**Includes:**
- ATMs and Teller Cash Recyclers (TCRs)
- Coin sorting machines
- Currency counters
- Bill validators
- Check scanners

#### 2. Security Systems
**Slug:** `security`  
**Icon:** security  
**Color:** #CF6679 (Red)

**Description:** Security, surveillance, and access control systems.

**Includes:**
- DVR and camera systems
- Access control locks
- Alarm systems
- Biometric readers

#### 3. Vault Equipment
**Slug:** `vault`  
**Icon:** shield  
**Color:** #FFC107 (Amber)

**Description:** Vault-specific equipment and environmental systems.

**Includes:**
- Pneumatic tube systems
- HVAC systems
- Vault doors and locks
- Environmental sensors

#### 4. Computing Systems
**Slug:** `computing`  
**Icon:** computer  
**Color:** #03DAC6 (Teal)

**Description:** IT infrastructure and computing equipment.

**Includes:**
- Workstations and PCs
- Network equipment (routers, switches)
- Printers and peripherals
- Servers

---

### Level 2: Equipment Types

#### Cash Handling Equipment Types

**ATM / TCR**
- Slug: `atm-tcr`
- Icon: atm
- Covers all automated teller machines and teller cash recyclers

**Coin Sorters**
- Slug: `coin-sorters`
- Icon: toll
- Coin counting and sorting machines

**Currency Counters**
- Slug: `currency-counters`
- Icon: attach_money
- Bill counting and authentication machines

**Validators**
- Slug: `validators`
- Icon: verified
- Bill validators and acceptors

#### Security Systems Types

**Surveillance**
- Slug: `surveillance`
- Icon: videocam
- DVR systems, cameras, recording equipment

**Access Control**
- Slug: `access-control`
- Icon: lock
- Electronic locks, biometric readers, access systems

#### Vault Equipment Types

**Pneumatic Systems**
- Slug: `pneumatic`
- Icon: settings_input_component
- Pneumatic tube systems and components

**HVAC Systems**
- Slug: `hvac`
- Icon: ac_unit
- Climate control for vault environments

---

### Level 3: Manufacturers/Variants

**Purpose:** Most specific level, typically manufacturer or specific product line

**Examples:**

Under ATM / TCR:
- Hyosung (all Hyosung ATM models)
- NCR (SelfServ, Personas series)
- Diebold Nixdorf (DN Series, Opteva)

Under Coin Sorters:
- JetSort (2000/3000 series)
- Kisan (Newton series)

Under Surveillance:
- March Networks
- Dahua
- Hikvision

**Guidelines:**
- Use official manufacturer names
- Create separate L3 for distinct product lines if needed
- Group similar models under one manufacturer

---

## Service Procedure Hierarchy

### Level 1: Service Domains

Five primary service types:

#### 1. Troubleshooting
**Slug:** `troubleshooting`  
**Icon:** build  
**Color:** #CF6679 (Red)

**Description:** Diagnosing and resolving equipment issues, error codes, and failures.

**When to use:** Article helps identify and fix problems

#### 2. Maintenance
**Slug:** `maintenance`  
**Icon:** handyman  
**Color:** #03DAC6 (Teal)

**Description:** Preventive and corrective maintenance procedures.

**When to use:** Scheduled maintenance or upkeep tasks

#### 3. Installation
**Slug:** `installation`  
**Icon:** construction  
**Color:** #9C27B0 (Purple)

**Description:** Installing new equipment or replacing components.

**When to use:** Setup, deployment, or replacement procedures

#### 4. Reference
**Slug:** `reference`  
**Icon:** library_books  
**Color:** #808080 (Grey)

**Description:** Reference materials, specifications, and documentation.

**When to use:** Informational content, specs, parts lists

#### 5. Safety & Compliance
**Slug:** `safety`  
**Icon:** warning  
**Color:** #FFC107 (Amber)

**Description:** Safety procedures and regulatory compliance.

**When to use:** Safety protocols, OSHA/ISO procedures

---

### Level 2: Service Subcategories

#### Troubleshooting Subcategories

**Diagnostic Procedures**
- Slug: `diagnostics`
- Initial diagnosis and assessment procedures

**Error Code Resolution**
- Slug: `error-codes`
- Specific error code troubleshooting

**Component Testing**
- Slug: `component-testing`
- Testing individual components

**Root Cause Analysis**
- Slug: `root-cause`
- In-depth problem analysis

#### Maintenance Subcategories

**Preventive Maintenance**
- Slug: `preventive`
- Scheduled maintenance tasks
- Further divided into: Daily, Weekly, Monthly (Level 3)

**Corrective Maintenance**
- Slug: `corrective`
- Repairs and corrections

**Calibration**
- Slug: `calibration`
- Equipment calibration procedures

#### Installation Subcategories

**New Equipment Setup**
- Slug: `new-setup`
- Complete new installations

**Component Replacement**
- Slug: `replacement`
- Replacing failed or worn components

**Configuration**
- Slug: `configuration`
- Software/firmware configuration

---

## Classification Guidelines

### Choosing the Right Category

**Equipment-Based Classification:**

1. Identify the primary equipment
2. Navigate down the hierarchy to most specific level
3. If article covers multiple equipment types, use the most prominent

**Example:**
- Article about ATM card reader → Cash Handling > ATM/TCR > Hyosung

**Service-Based Classification:**

1. Determine primary purpose of the article
2. Choose appropriate service domain
3. Select most specific subcategory

**Example:**
- Error code troubleshooting → Troubleshooting > Error Code Resolution

### Difficulty Level Guidelines

**Beginner:**
- Basic tasks requiring minimal technical knowledge
- Clear step-by-step instructions
- No specialized tools required
- Examples: Visual inspections, basic cleaning, reading error codes

**Intermediate:**
- Requires technical understanding
- May involve opening panels or accessing internals
- Standard tools (screwdrivers, multimeters)
- Examples: Component testing, routine maintenance, simple repairs

**Advanced:**
- Requires significant technical expertise
- Complex diagnostic procedures
- Specialized tools or equipment
- Examples: Circuit board repair, firmware updates, complex calibration

**Expert:**
- Highly specialized procedures
- Requires certification or extensive experience
- May involve safety-critical systems
- Examples: Complete system rebuilds, advanced programming, vault modifications

### Safety Level Guidelines

**None:**
- Standard safety procedures apply
- No unusual hazards
- Examples: Software configuration, documentation review

**Caution:**
- Exercise care
- Potential for minor injury or equipment damage
- Examples: Opening panels, cleaning mechanisms, basic electrical work

**Warning:**
- Significant hazards present
- Potential for injury or major equipment damage
- Requires proper PPE and procedures
- Examples: Working with mains voltage, confined spaces, heavy components

**Danger:**
- High-risk procedure
- Potential for serious injury or death
- Only qualified personnel
- Requires lockout/tagout
- Examples: Vault entry during operations, high-voltage systems, gas systems

### Priority Level Guidelines

**Critical:**
- Service-affecting issues
- Revenue impact
- Safety-critical failures
- Examples: ATM out of cash, security system down, vault door malfunction

**High:**
- Important but not immediately service-affecting
- Degraded operation
- Potential to become critical
- Examples: Receipt printer jam, slow transaction times, intermittent errors

**Standard:**
- Routine procedures
- Normal maintenance
- General improvements
- Examples: Scheduled maintenance, cosmetic issues, documentation updates

**Low:**
- Nice-to-know information
- Optional optimizations
- Future planning
- Examples: Feature guides, historical information, upcoming changes

---

## Tagging Strategy

### Tag Categories

**Issue Type Tags:**
- error-codes
- jam-clearing
- calibration
- firmware-update
- configuration

**Complexity Tags:**
- quick-fix (< 10 minutes)
- advanced-procedure
- beginner-friendly

**Safety Tags:**
- safety-critical
- electrical-hazard
- lockout-tagout
- confined-space

**Service Context Tags:**
- preventive-maintenance
- emergency-repair
- warranty-service
- post-installation

**Component Tags:**
- card-reader
- cash-dispenser
- receipt-printer
- power-supply
- network-connection

**Documentation Tags:**
- step-by-step
- reference-only
- troubleshooting-guide
- parts-catalog

### Tagging Best Practices

**Do:**
- Use 3-5 tags per article
- Choose tags that aren't obvious from category
- Use tags for cross-cutting concerns
- Create new tags when patterns emerge

**Don't:**
- Don't duplicate category information in tags
- Don't create one-off tags (reuse existing)
- Don't over-tag (diminishes usefulness)
- Don't use vague tags ("important", "useful")

---

## Common Scenarios

### Scenario 1: ATM Error Code Article

**Equipment Classification:**
- Domain: Cash Handling Equipment
- Type: ATM / TCR
- Manufacturer: Hyosung

**Service Classification:**
- Domain: Troubleshooting
- Type: Error Code Resolution

**Metadata:**
- service_type: troubleshooting
- difficulty_level: intermediate
- safety_level: caution
- priority_level: high

**Tags:**
- error-codes
- card-reader
- diagnostics

### Scenario 2: Preventive Maintenance Checklist

**Equipment Classification:**
- Domain: Cash Handling Equipment
- Type: ATM / TCR
- Manufacturer: (applicable to all)

**Service Classification:**
- Domain: Maintenance
- Type: Preventive Maintenance
- Subtype: Daily Checks

**Metadata:**
- service_type: maintenance
- difficulty_level: beginner
- safety_level: none
- priority_level: standard

**Tags:**
- preventive-maintenance
- checklist
- daily-routine

### Scenario 3: Component Replacement

**Equipment Classification:**
- Domain: Cash Handling Equipment
- Type: Coin Sorters
- Manufacturer: JetSort

**Service Classification:**
- Domain: Installation
- Type: Component Replacement

**Metadata:**
- service_type: installation
- difficulty_level: advanced
- safety_level: warning
- priority_level: high

**Tags:**
- component-replacement
- warranty-service
- step-by-step

---

## Future Enhancements

**Planned additions to taxonomy:**
- Client-specific categories (RBFCU procedures, etc.)
- Region-specific regulations
- Certification requirements
- Training pathways

**Feedback:**
Send taxonomy suggestions to the Knowledge Base Owner.

---

**End of Taxonomy Guide**
