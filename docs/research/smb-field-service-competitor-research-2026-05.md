---
title: SMB field-service competitor research (actionable digest)
date: 2026-05-03
audience: FSC Portal product / build decisions
sources: vendor primary pages + one secondary review where noted
---

# SMB field-service competitor research

This document gives **concrete, cited capability lists** from products that overlap your roadmap (dispatch, GPS, inventory, comms, invoicing, hybrid mobile). Use it to score **your build vs market expectations**, not as legal/commercial advice.

**Your positioning anchors** (from internal requirements): **local-first / offline-capable + online when available** (see **R36** in `docs/brainstorms/2026-05-01-fsc-portal-overhaul-requirements.md`), optional **fleet GPS via third-party adapter**, **truck/branch inventory & swaps**, **equipment dossier (photos/serial)**, **grounded local knowledge / EVA**—most incumbents below are **cloud-primary**; note where they still claim offline or field value.

---

## 1. Source index (bookmark these)

| Product | Primary feature / marketing pages used |
| :--- | :--- |
| **Jobber** | [Features hub](https://www.getjobber.com/features/), [Scheduling](https://www.getjobber.com/features/scheduling/) |
| **Housecall Pro** | [Features overview](https://www.housecallpro.com/features/), [Dispatching](https://www.housecallpro.com/features/dispatching-software-revamp/), [Invoicing](https://housecallpro.com/features/invoicing-software) |
| **Workiz** | [Features](https://www.workiz.com/features/), [Dispatching](https://www.workiz.com/features/dispatching/), [Phone / comms](https://www.workiz.com/features/phone-system/) |
| **FieldPulse** | [FSM features](https://www.fieldpulse.com/features), [Inventory blog (product capabilities)](https://www.fieldpulse.com/resources/blog/field-service-inventory-management) |
| **Secondary (pricing / add-ons)** | [FieldPulse review with add-on pricing notes](https://fieldcamp.ai/reviews/fieldpulse/) — **verify** against FieldPulse quotes before relying on numbers |

---

## 2. Jobber — what they document (home / commercial services)

From [Scheduling](https://www.getjobber.com/features/scheduling/) and [Features](https://www.getjobber.com/features/) (paraphrased; confirm on live pages):

| Theme | Documented capability |
| :--- | :--- |
| **Scheduling** | Customer online booking; calendar; drag/drop reschedule; route generation before dispatch; automated visit reminders |
| **Fleet GPS** | **Integration**: schedule/monitor fleet with **Fleetsharp** real-time GPS inside Jobber ([scheduling page](https://www.getjobber.com/features/scheduling/) → App Marketplace link) — *adapter pattern similar in spirit to your “company GPS API” idea* |
| **Field evidence** | Integrations for unlimited jobsite photos (e.g. **CompanyCam** marketplace link on same page) |
| **Work & money** | Work orders, invoicing (quick-create, reminders, batch), payments, job costing / financial management sections on features hub |
| **Automation / ecosystem** | Zapier / “2,000+ tools” automation messaging on scheduling page |
| **AI** | Marketing: Jobber AI for pricing / upsell prompts ([homepage positioning](https://www.getjobber.com/)) |
| **Offline / local-first** | **Not** positioned as local DB–first; mobile apps exist—treat as **cloud + mobile** baseline |

**Research takeaway for you:** Jobber is the “polished SMB default.” **Parity pressure:** scheduling + client comms + invoicing + mobile. **Differentiation room:** true offline-first SQLite, your **fleet-vendor adapter** (they use Fleetsharp partnership), **replace-vs-repair + serial dossier** depth if you exceed generic “job forms + photos.”

---

## 3. Housecall Pro — what they document (trades / dispatch-heavy)

From [Features](https://www.housecallpro.com/features/), [Dispatch revamp](https://www.housecallpro.com/features/dispatching-software-revamp/), [Invoicing](https://housecallpro.com/features/invoicing-software):

| Theme | Documented capability |
| :--- | :--- |
| **Dispatch** | Single dispatch view; drag-and-drop; calendar + **map**; **live vehicle/job tracking**; route optimization narrative |
| **GPS / customer** | “On my way” texts with **GPS-powered ETAs**; vehicle visibility |
| **Invoicing / payments** | One-click digital invoices; reminders; cards/ACH; **QuickBooks** sync messaging; progress invoicing (large jobs) |
| **Voice** | “Voice to invoicing” feature line on features index |
| **Offline / local-first** | Same as Jobber: **cloud-native** story; strong **connectivity** and **real-time** expectations |

**Research takeaway:** Strong **evidence** for what your dispatchers will compare to: **map + live tracking + ETA comms**. Your plan to combine **phone + vehicle telematics** with explicit **source metadata** (requirements **R31–R33** when that branch is merged) is a sane response to “HCP already shows my trucks.”

---

## 4. Workiz — what they document (phone + dispatch + SMB)

From [Features](https://www.workiz.com/features/), [Dispatching](https://www.workiz.com/features/dispatching/), [Phone system](https://www.workiz.com/features/phone-system/):

| Theme | Documented capability |
| :--- | :--- |
| **Dispatch** | Calendar, drag/drop; assign by availability / skill / **proximity**; **real-time GPS** for trucks/techs; “On my way” style comms |
| **Comms / AI** | Built-in **phone**; **AI answering** (“Genius Answering”) for missed calls → booking; call recording/transcripts; smart routing; **call masking** |
| **Integrations** | **QuickBooks** sync (dispatch help page FAQ); Google Calendar, others listed |
| **Mobile** | Native app: estimates/invoices in field; location tracking per marketing copy |

**Research takeaway:** If you add **dispatcher reroute + tech accountability**, buyers will mentally compare to **Workiz’s comms stack** (recordings, masking, AI phone). You can **skip building a full phone system** early and still win on **field + inventory graph**—but document the decision.

---

## 5. FieldPulse — what they document (scaling trades + inventory story)

From [Features](https://www.fieldpulse.com/features) and [Inventory management guide](https://www.fieldpulse.com/resources/blog/field-service-inventory-management):

| Theme | Documented capability |
| :--- | :--- |
| **Core FSM** | Work orders, scheduling & dispatch, dashboards/reporting, estimates/invoices, payments, custom workflows, CRM, mobile, projects, customer portal (features page) |
| **Job quality** | **ClearPath** — stage-gated job flows so required details get collected |
| **Inventory** | Real-time tracking; **hubs** (warehouse / office / **vehicle**); parts linked to **jobs + invoices**; usage decrements stock; **reorder alerts**; **barcode scan** from phone; **serialized** high-value items; material lists for projects (blog) |
| **Fleet add-on (secondary source)** | Third-party review: **Azuga**-based fleet tracking ~**$30/vehicle/mo** claim — **[verify with FieldPulse](https://fieldcamp.ai/reviews/fieldpulse/)** before quoting |
| **AI add-ons (secondary)** | Review claims **Operator AI** / **Chat AI** as paid add-ons — verify on vendor |

**Research takeaway:** FieldPulse’s **inventory + hubs + serialize + job link** language maps closely to your **R27–R30** direction. Use their blog as a **checklist** for parity: hubs, barcodes, serialized assets, auto reorder, invoice linkage.

---

## 6. Cross-vendor matrix (high level)

Legend: **Strong** = prominently documented; **Partial** = exists in ecosystem/add-on or light mention; **n/a** = not the product’s story.

| Capability dimension | Jobber | Housecall Pro | Workiz | FieldPulse | Notes for **your** portal |
| :--- | :---: | :---: | :---: | :---: | :--- |
| Cloud-first / real-time sync | Strong | Strong | Strong | Strong | You compete on **hybrid**: offline-capable core + online ([R36](../brainstorms/2026-05-01-fsc-portal-overhaul-requirements.md)) |
| Scheduling / dispatch UI | Strong | Strong | Strong | Strong | Parity bar for **dispatcher workspace** |
| GPS / map / ETAs | Strong (incl. Fleetsharp) | Strong (built-in narrative) | Strong | Partial (fleet via add-on per review) | Your **adapter** model vs their bundled/partner GPS |
| Inventory / truck / serialized | Partial / marketplace | Partial (features index mix) | Partial | **Strong** (blog detail) | **FieldPulse = best public inventory depth** among this set |
| Invoicing / QBO | Strong | Strong | Strong | Strong | You’ve deferred full accounting—**risk** vs buyer expectations |
| Comms (SMS/voice/AI phone) | Partial | Strong | **Very strong** | Partial / Engage | Workiz leads **telephony**; you may integrate later |
| Job forms / photos | Strong | Strong | Strong | Strong (e.g. CompanyCam integration in updates) | Your **equipment photo dossier** can exceed generic job photos |
| Local embedded “AI” on device | n/a | n/a | n/a | Add-on cloud AI (review) | Your **EVA / local retrieval** path is a real differentiator **if** shipped |

---

## 7. Map to *your* planned modules (gap → action)

| Your theme | vs competitors | Suggested product action |
| :--- | :--- | :--- |
| **Hybrid offline + sync** | Others assume connectivity | Ship **visible sync state**, queue/retry rules, **acceptance-style** tests per brainstorm; market as differentiator |
| **Dispatcher + reroute** | HCP / Workiz set expectations on map + GPS | Match **clarity** of map + assignment; add **vehicle vs phone** source semantics |
| **Fleet GPS via existing vendor** | Jobber uses Fleetsharp integration | Finish **adapter interface** + one pilot integration; don’t rebuild Azuga |
| **Truck inventory + peer swap** | FieldPulse articulates hubs + job-linked parts best | Use FieldPulse blog as **acceptance checklist**; prove **nearest-tech swap** in your UX |
| **Branch equipment + serial + replace** | Generic “assets/forms” everywhere | **Own** the replace-vs-repair + serial + photo depth for your vertical |
| **Knowledge / grounded help** | Cloud AI assistants on competitors | Keep **local + cited**; avoid generic chatbot positioning |
| **Accounting** | QBO sync is table stakes for many SMBs | Minimum: **export** or timeline for QBO; document gap honestly in sales |

---

## 8. How to keep this research “live”

1. **Quarterly:** re-open each primary URL; note **dated** changes in the [competitive matrix](./competitive-field-service-matrix.md) sources log.  
2. **Before a demo or license pitch:** pick **3 competitors** your prospect actually names; copy rows 6 + 7 for them only.  
3. **Pricing:** never rely on a single blog—**capture a screenshot** or PDF from the vendor pricing page when you buy or trial.

---

## 9. Internal build order vs this research

**Live build priority:** **Hybrid offline + online** and **core program updates** first. **Fleet / vehicle GPS** integration (matching Jobber Fleetsharp–class or HCP live-map expectations) is **on the roadmap** only after **access to the real fleet/GPS system** and vendor/API facts—not inferred from this document. Use §§2–5 as **future parity** targets, not same-sprint scope.

---

## 10. Disclaimer

Vendor pages are **marketing**. Review sites mix **facts, estimates, and opinion**. This digest is for **internal product research**; verify before contractual or competitive claims.
