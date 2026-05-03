---
title: Competitive field-service and operations matrix
purpose: Living benchmark for FSC Portal positioning; align rows to docs/brainstorms/2026-05-01-fsc-portal-overhaul-requirements.md (including R36 hybrid connectivity).
cadence: quarterly review, or before licensing or major release
last_updated: 2026-05-03
---

# Competitive matrix (living document)

This file compares **publicly documented** capabilities of SMB-to-mid-market field-service and adjacent products to **this portal’s intended** capabilities. Ratings are directional until each cell is backed by a dated source note.

**Filled research digest (2026-05-03):** [smb-field-service-competitor-research-2026-05.md](./smb-field-service-competitor-research-2026-05.md) — competitor capability lists, citations, and gap table.

## How to use

1. **Rows:** capability areas aligned to overhaul requirements (R1–R36 as adopted in the brainstorm doc) and stakeholder themes (offline-capable + online, local knowledge, fleet adapter, etc.).
2. **Columns:** named products or categories. Add or remove competitors as the beachhead vertical becomes firm.
3. **Cells:** `ahead` | `parity` | `behind` | `n/a` | `unknown`, plus a **short evidence note** (vendor page, docs URL, review date). Prefer primary sources (vendor pricing/features pages) over blogs when possible.
4. **Refresh:** update `last_updated` and skim for pricing or feature page changes at least quarterly.

## Legend

| Symbol | Meaning |
| :--- | :--- |
| ahead | Differentiator we intend to lead on |
| parity | Match market expectation for SMB |
| behind | Known gap to close or accept as non-goal |
| n/a | Not applicable to that product’s positioning |
| unknown | Not yet researched; do not infer |

## Starter competitor set (edit freely)

Examples commonly cited for SMB field service (not an endorsement list): **Jobber**, **Housecall Pro**, **Workiz**, **Kickserv**, **FieldPulse**, **FieldEdge** (QuickBooks Desktop–heavy shops), **ServiceTitan** (upstream enterprise), vertical specialists as needed (e.g. pest, pool route, roofing).

## Capability rows (starter) — evidence pass 2026-05-03

Ratings below are **from vendor primary pages** summarized in [smb-field-service-competitor-research-2026-05.md](./smb-field-service-competitor-research-2026-05.md). `parity` = “buyers will expect something in this ballpark.”

| Capability / theme | This portal (intent) | Jobber | Housecall Pro | Workiz | FieldPulse | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Offline-first / local DB truth | **ahead** | behind (cloud) | behind (cloud) | behind (cloud) | behind (cloud) | None market local SQLite–first; mobile offline claims need per-app verification |
| Hybrid offline + online sync (R36) | **ahead** | parity (mobile+sync) | parity | parity | parity | You need explicit **queued sync** UX + tests |
| Dispatcher / calendar / reroute | parity (R12) | **parity** | **parity** | **parity** | **parity** | Jobber drag/drop + routes; HCP map+live; Workiz proximity assign |
| Live GPS / map / ETA to customer | parity | **parity** (Fleetsharp + routes) | **parity** (vehicle GPS, on-my-way SMS) | **parity** (real-time GPS, OMW) | partial (fleet add-on per secondary review) | See digest §2–5 |
| Use **your** fleet vendor’s GPS API | **ahead** (adapter) | partial (Fleetsharp partner) | unknown | unknown | partial (Azuga add-on narrative) | Different integration model |
| Inventory hubs truck ↔ job ↔ invoice | parity (R28–R30) | partial | partial | partial | **parity** (strong public write-up) | FieldPulse blog = checklist |
| Serialized / barcode parts | parity | partial | partial | partial | **parity** | FieldPulse documents barcode + serialized |
| Built-in phone + AI answering | behind (optional) | partial | strong | **very strong** | partial | Workiz [phone-system](https://www.workiz.com/features/phone-system/) depth |
| QBO / payments / invoicing | behind until shipped | **parity** | **parity** | **parity** | **parity** | Table stakes for many SMBs |
| Local grounded assistant (EVA) | **ahead** (if shipped) | partial (cloud AI) | partial | partial | partial (add-on AI reviews) | Different architecture |

## Sources log (append-only)

| date | product | URL or reference | what was verified |
| :--- | :--- | :--- | :--- |
| 2026-05-03 | — | — | Template created; cells to be filled with evidence. |
| 2026-05-03 | Jobber | [getjobber.com/features](https://www.getjobber.com/features/), […/scheduling](https://www.getjobber.com/features/scheduling/) | Scheduling, Fleetsharp GPS, CompanyCam, Zapier claims |
| 2026-05-03 | Housecall Pro | [housecallpro.com/features](https://www.housecallpro.com/features/), [dispatching-software-revamp](https://www.housecallpro.com/features/dispatching-software-revamp/) | Live map, vehicle GPS, OMW SMS, invoicing+QBO messaging |
| 2026-05-03 | Workiz | [workiz.com/features](https://www.workiz.com/features/), [dispatching](https://www.workiz.com/features/dispatching/), [phone-system](https://www.workiz.com/features/phone-system/) | GPS, Genius Answering, call masking, QBO FAQ |
| 2026-05-03 | FieldPulse | [fieldpulse.com/features](https://www.fieldpulse.com/features), [inventory blog](https://www.fieldpulse.com/resources/blog/field-service-inventory-management) | Hubs, barcode, serialized, job link |
| 2026-05-03 | FieldPulse pricing | [fieldcamp.ai review](https://fieldcamp.ai/reviews/fieldpulse/) | Add-on estimates only — **re-verify before use** |

## Gaps to drive backlog

After each review, paste 3–5 bullets into `docs/plans/` or issue tracker:

- **Parity gaps** (must ship to be credible in SMB comparisons).
- **Differentiation** (keep and sharpen).
- **Non-goals** (explicitly not competing on X).
