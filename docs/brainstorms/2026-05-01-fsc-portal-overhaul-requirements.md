---
date: 2026-05-01
topic: fsc-portal-overhaul
status: draft
---

# FSC Portal Overhaul Requirements

## Problem Frame

FSC Portal needs to move from a mostly functional offline desktop tool into a fully wired operations platform for field service, dispatch, sales, knowledge, equipment, expenses, location intelligence, and local AI assistance. The current repo shows strong building blocks: a Flutter offline-first app, Drift/SQLite database, knowledge base search, work order services, operations views, equipment views, expense schema, and EVA assistant shell. The gap is that several modules are unfinished, inconsistently wired, or not yet cohesive enough for daily operational use.

This document turns the requested "Landing Pad" and overall improvement effort into a formal product requirements brief. It defines what needs to be fixed or expanded before detailed implementation planning. It intentionally avoids code-level decisions, but it does ground scope in existing repository signals such as `FSC-Portal/lib/database/app_database.dart`, `FSC-Portal/lib/features/expenses/expenses_home_view.dart`, `FSC-Portal/lib/features/operations/operations_view.dart`, `FSC-Portal/lib/services/eva_service.dart`, and `FSC-Portal/docs/WORK_ORDER_MANAGEMENT.md`.

---

## Current Product Signals

- The active portal appears to be a Flutter offline-first app under `FSC-Portal/`, with desktop support and an existing local database.
- `FSC-Portal/PROJECT_STATUS_REPORT_2026.md` describes the app as beta with strong core modules, but explicitly calls out partial work in EVA, work order editing, equipment management, and expenses.
- `FSC-Portal/docs/WORK_ORDER_MANAGEMENT.md` documents a mature work order workflow model with state transitions, audit logging, permissions, and optimistic locking.
- `FSC-Portal/lib/database/app_database.dart` already contains core local data tables for clients, sites, users, work orders, equipment, knowledge entries, expenses, audit logs, documents, and related operational data.
- `FSC-Portal/lib/features/expenses/expenses_home_view.dart` is still a placeholder, even though the database has an `Expenses` table.
- `FSC-Portal/lib/services/local_llm_provider.dart` currently treats ONNX inference as disabled, so EVA falls back to search and scripted/intention-based behavior rather than a working embedded model.
- `Offline-Portal/KNOWLEDGE_BASE_ARCHITECTURE.md` and related knowledge documents describe a more organized knowledge base model that should inform cleanup and taxonomy decisions.

---

## Product Thesis

The upgraded FSC Portal should become the local-first operating system for field service work:

- The Landing Pad gives every role a clear "what needs attention now" view.
- Dispatchers can triage, assign, and monitor tickets without losing context.
- Technicians can find locations, equipment, work orders, knowledge, expenses, and backup state from one coherent workflow.
- Managers can trust the database as the source of truth for organizations, locations, equipment, work, expenses, and sales activity.
- EVA stays small, local, useful, and grounded in FSC data instead of trying to become a general chatbot.

---

## Actors

- A1. Field Technician: Uses the portal in the field to view assigned work, location data, equipment history, knowledge articles, expenses, and EVA help.
- A2. Dispatcher: Creates, triages, schedules, assigns, and monitors tickets and technician workload.
- A3. Operations Manager: Oversees organizations, locations, equipment health, work order metrics, expenses, and reporting.
- A4. Sales User: Manages prospects, customers, opportunities, proposals, and handoff into operations.
- A5. Admin / System Owner: Configures users, data imports, backups, permissions, integrations, and local deployment.
- A6. EVA Assistant: Local embedded assistant that searches, summarizes, and guides users using approved FSC data.
- A7. Mobile User: Uses iOS or Android app surfaces for field capture, dispatch updates, location access, and expenses.

---

## Key Flows

- F1. Landing Pad Daily Start
  - **Trigger:** A user opens the portal.
  - **Actors:** A1, A2, A3, A4, A6
  - **Steps:** The portal identifies role context, loads local data, shows urgent work, stale records, alerts, tickets, upcoming jobs, expense drafts, backup status, and EVA suggestions.
  - **Outcome:** The user knows what to do next within 30 seconds.
  - **Covered by:** R1, R2, R3, R18, R20

- F2. Ticket Dispatch Lifecycle
  - **Trigger:** A new service request or ticket enters the system.
  - **Actors:** A2, A1, A3
  - **Steps:** Dispatcher creates or receives ticket, attaches organization/location/equipment, sets priority, assigns technician, tracks status, handles blockers, and closes the loop with notes and audit history.
  - **Outcome:** Work is traceable from request to completion with no orphaned ticket state.
  - **Covered by:** R10, R11, R12, R13

- F3. Location and Equipment Lookup
  - **Trigger:** A user searches for a branch, organization, machine, serial number, route, or service history.
  - **Actors:** A1, A2, A3, A6
  - **Steps:** User searches or opens map/list, filters by organization/region/equipment, reviews validated location details, sees equipment installed at the site, and can launch related work or knowledge.
  - **Outcome:** Location and equipment data is accurate, navigable, and operationally useful.
  - **Covered by:** R6, R7, R8, R9, R19

- F4. Expense Capture and Report Submission
  - **Trigger:** A technician needs to record field expenses.
  - **Actors:** A1, A3
  - **Steps:** User enters expense, attaches receipt, links work order/location when relevant, saves draft offline, submits report, manager reviews, export/report is generated.
  - **Outcome:** Expenses are complete, auditable, and connected to work activity.
  - **Covered by:** R14, R15, R16

- F5. Knowledge Search and EVA Help
  - **Trigger:** A user asks a question, searches documentation, or opens equipment-specific help.
  - **Actors:** A1, A2, A3, A6
  - **Steps:** EVA retrieves local knowledge, filters by context, summarizes only grounded content, cites source entries, suggests next actions, and gracefully falls back when no answer exists.
  - **Outcome:** Users get fast, trustworthy local help without needing a large cloud model.
  - **Covered by:** R4, R5, R21, R22

- F6. Local Backup and Recovery
  - **Trigger:** App starts, app exits, scheduled backup time arrives, or admin requests backup.
  - **Actors:** A5
  - **Steps:** Portal checks backup configuration, creates versioned local backup, verifies integrity, records metadata, exposes recovery path, and warns when backup health is poor.
  - **Outcome:** Installed systems can recover from local database corruption, accidental deletion, or machine failure scenarios.
  - **Covered by:** R17, R18

---

## Requirements

**Landing Pad and UI/UX**

- R1. The portal must provide a redesigned Landing Pad that acts as the primary role-aware starting point for field technicians, dispatchers, operations managers, sales users, and admins.
- R2. The UI must be cleaned up into a consistent visual system across dashboard, work, operations, locations, equipment, knowledge, expenses, settings, and EVA surfaces.
- R3. Every primary module shown in navigation must be wired to live local data, useful empty states, loading states, error states, and clear next actions.

**Knowledge Base**

- R4. The knowledge base must be cleaned up, deduplicated, categorized, and organized around the actual field-service taxonomy: equipment, service procedure, troubleshooting, safety, manufacturer, model, and difficulty.
- R5. Knowledge search must support both browsing and task-based retrieval, with source visibility, stale-content indicators, and a review workflow for deprecated or low-quality entries.

**Locations and Location Data**

- R6. Location data must be updated, validated, and normalized so each location has trustworthy organization, address, coordinates, region, contact, notes, and service metadata.
- R7. Location views must support practical field workflows: map browsing, list filtering, route context, site detail, equipment at site, service history, and launch-to-navigation.
- R8. Location imports or edits must prevent duplicate branches, bad coordinates, missing organization links, and ambiguous names.

**Equipment and Organizations**

- R9. Equipment data must be fully wired to organizations, locations, work orders, knowledge entries, warranty/service-contract status, service history, and active/retired state.
- R10. Organization data must become a first-class domain rather than only a loose client/site grouping, supporting customer hierarchy, contacts, locations, equipment, tickets, opportunities, and reporting.

**Operations and Ticketing**

- R11. The ticketing/work order system must be reconfigured into a complete operational workflow for intake, triage, assignment, status transitions, notes, attachments, equipment links, and closure.
- R12. Dispatchers must have a dedicated dispatch view for queue management, technician workload, SLA/priority visibility, scheduling, and ticket reassignment.
- R13. Work orders must preserve auditability: who changed what, when, why, from which status, and with which linked assets or expenses.

**Expenses**

- R14. The expense report system must be fully wired from placeholder state to working feature: create, edit, attach receipt, categorize, link to work/location, submit, approve/reject, export, and search.
- R15. Expenses must support offline drafting and later reconciliation without duplicate reports or lost receipt paths.
- R16. Expense reporting must have enough validation to prevent incomplete reports, unsupported categories, orphaned receipts, or unreviewable submissions.

**Local Backup and Recovery**

- R17. The installed app must create local backups on the machine where it is installed, with configurable location, retention, integrity checks, and recovery visibility.
- R18. Backup health must appear in admin/settings and surface warnings on the Landing Pad when backups are stale, failing, or unconfigured.

**Sales Platform**

- R19. A sales platform must be added or scoped to manage leads, prospects, organizations, contacts, opportunities, proposal status, follow-ups, and handoff from sales to operations.
- R20. Sales data must connect to organization/location data so customers are not duplicated between sales and operations.

**Mobile Apps**

- R21. iOS and Android app requirements must be defined from the same product model, prioritizing field capture, dispatch updates, expense receipts, location lookup, and offline access.
- R22. Mobile scope must not fork core business logic away from the local-first portal model; it should reuse shared data contracts and role flows where possible.

**EVA Local Embedded AI**

- R23. EVA must either be repaired or redesigned as a small local assistant focused on search, summarization, contextual guidance, and field-service help.
- R24. EVA must remain small enough to run practically on installed machines and must never require a large always-online cloud model for core help/search.
- R25. EVA answers must be grounded in local FSC content, show sources when possible, and admit uncertainty when the knowledge base lacks an answer.

**Integrations**

- R26. Teams integration and/or Flowspace integration must be evaluated as optional communication/orchestration layers, not assumed as mandatory dependencies until a clear operational workflow is chosen.

---

## Acceptance Examples

- AE1. **Covers R1, R3.** Given a dispatcher opens the portal, when the Landing Pad loads, they see unassigned tickets, high-priority work, technician workload, backup warnings, and clear shortcuts into dispatch actions.
- AE2. **Covers R4, R5, R23, R25.** Given a technician asks EVA about a machine issue, when relevant knowledge exists, EVA returns a concise answer with source entries and suggested follow-up actions.
- AE3. **Covers R6, R7, R8.** Given an admin imports updated branch data, when duplicates or invalid coordinates are detected, the system flags them for review instead of silently creating bad locations.
- AE4. **Covers R9, R10.** Given an operations manager opens an organization, they can see all related locations, equipment, open tickets, recent service, expenses, and sales context.
- AE5. **Covers R11, R12, R13.** Given a dispatcher reassigns a high-priority ticket, when the change is saved, the ticket history records the reassignment, reason, actor, timestamp, and affected technician.
- AE6. **Covers R14, R15, R16.** Given a technician creates an expense report offline with receipt photos, when connectivity or sync returns, the report remains intact and does not duplicate receipts or amounts.
- AE7. **Covers R17, R18.** Given the local backup job fails for multiple days, when an admin opens the app, backup health is visibly degraded and recovery guidance is available.
- AE8. **Covers R19, R20.** Given a sales user converts a prospect into an active customer, when operations receives the handoff, the organization record is reused rather than duplicated.
- AE9. **Covers R21, R22.** Given a technician uses the mobile app, they can view assigned work, update status, capture receipts/photos, and use essential location data without relying on a separate business model.
- AE10. **Covers R24, R25.** Given the local AI model is unavailable or too heavy for a machine, EVA still provides useful deterministic knowledge search and does not block core portal workflows.

---

## Success Criteria

- The portal feels like one cohesive operations system instead of separate partially wired modules.
- Every navigation destination either performs useful work or clearly explains what is missing and how the user proceeds.
- Locations, organizations, equipment, work orders, expenses, and knowledge entries share consistent relationships.
- A dispatcher can run daily ticket flow from the portal without external spreadsheets.
- A technician can complete a normal field-service loop: review job, open location, inspect equipment history, use knowledge/EVA, update ticket, attach evidence, and submit expenses.
- An admin can trust backup status and recover from local data loss.
- EVA is useful even when local LLM inference is unavailable, and better when a small model is working.
- The next implementation plan can split this into phased work without inventing product behavior.

---

## Scope Boundaries

### Deferred for later

- Full cloud multi-tenant SaaS architecture is not required for the first overhaul pass.
- Advanced AI agent autonomy is deferred until EVA search/help is reliable, grounded, and small.
- Full ERP/accounting integration is deferred until expense reporting and sales records work locally.
- Full route optimization beyond practical dispatch/location improvements is deferred unless it becomes a top operational bottleneck.

### Outside this product's identity

- The portal should not become a generic CRM disconnected from FSC field operations.
- EVA should not become a general-purpose chatbot with unbounded internet answers.
- Mobile apps should not become separate products with separate business rules.
- Teams or Flowspace should not become required just to operate the local portal.

---

## Key Decisions

- Treat this as a platform overhaul, not a visual-only refresh: UI improvement must happen alongside wiring and data integrity work.
- Keep local-first behavior as a core product constraint: backup, offline drafts, and embedded help matter because the portal may run on installed machines in field-service contexts.
- Make organizations, locations, equipment, work orders, and expenses the central operational graph.
- Repair the current work order/ticketing surface before adding complex dispatch features, because dispatch depends on reliable ticket lifecycle data.
- Build Sales and Dispatcher platforms as role-specific workspaces inside the same portal model, not disconnected apps.
- Evaluate Teams and Flowspace after core operational flows are reliable, because integration should amplify workflows rather than compensate for missing ones.
- Redesign EVA around grounded retrieval first, with local LLM synthesis as an enhancement, not a dependency.

---

## Dependencies / Assumptions

- The existing Flutter/Drift local database remains the near-term source of truth unless implementation planning decides otherwise.
- Current partial features in `FSC-Portal/` are preferred over starting from a blank app, but modules may need overhaul when wiring is incomplete or data models are insufficient.
- Existing work order workflow documentation is a strong starting point and should not be thrown away without a specific reason.
- The sales platform, dispatcher platform, and mobile apps need product-level scope refinement before implementation.
- Local backup must account for database files, attachments/receipts, imported knowledge, and configuration, not just schema data.
- EVA model choice must be validated against machine constraints, installation size, startup time, memory use, and answer usefulness.

---

## Risks

- **Over-scope risk:** This is large enough to become several projects. Mitigation: split into phased implementation plans after this requirements doc.
- **Data migration risk:** Equipment, organization, location, and expense overhaul may require schema changes. Mitigation: characterize current data and add migration tests before changing persisted tables.
- **UX polish without wiring risk:** A nicer interface could hide incomplete data flows. Mitigation: require each UI upgrade to include data, empty, error, and action states.
- **AI complexity risk:** Local LLM work can consume time without improving field outcomes. Mitigation: make retrieval/search quality the baseline and treat model synthesis as optional.
- **Mobile divergence risk:** iOS/Android apps could fork business logic. Mitigation: define shared data contracts and role flows before building mobile screens.
- **Integration distraction risk:** Teams or Flowspace could become premature architecture. Mitigation: evaluate only after dispatch/workflow events are reliable in the portal.

---

## Outstanding Questions

### Resolve Before Planning

- [Affects R19, R20][User decision] Should the Sales Platform be a first-class module in this overhaul, or a phase-two module after operations/ticketing is stabilized?
- [Affects R21, R22][User decision] Are iOS/Android apps required for the first market-ready release, or should mobile be planned after the desktop/local portal is stable?
- [Affects R26][User decision] Should Flowspace be treated as the preferred integration target over Microsoft Teams, or should both be compared during planning?

### Deferred to Planning

- [Affects R6-R10][Technical] Determine whether the existing `clients` and `sites` model is enough or whether a dedicated organizations model is required.
- [Affects R11-R13][Technical] Determine how much of the documented work order workflow is implemented versus only documented.
- [Affects R14-R16][Technical] Determine whether expense receipts should be stored as local file paths, managed documents, or backup-aware attachments.
- [Affects R17-R18][Technical] Determine which local backup format and retention strategy best fits installed-machine use.
- [Affects R23-R25][Needs research] Compare viable small local EVA strategies: improved FTS/ranking, embeddings, tiny ONNX model, llama.cpp-compatible local model, or hybrid retrieval plus deterministic templates.

---

## Recommended Phasing

- Phase 1: Stabilize foundation and UX shell: Landing Pad, navigation consistency, module status, shared empty/error/loading states, and backup visibility.
- Phase 2: Data integrity pass: organizations, locations, equipment, work order links, seed/import cleanup, and duplicate prevention.
- Phase 3: Operations and dispatch: ticket lifecycle, dispatcher workspace, assignment, audit, attachments, and service history.
- Phase 4: Expenses: receipt capture, reports, approval, exports, and work/location linkage.
- Phase 5: Knowledge and EVA: taxonomy cleanup, review workflow, improved search, small local assistant strategy, and source-grounded responses.
- Phase 6: Sales platform: prospect/customer/opportunity flow and handoff into organizations/operations.
- Phase 7: Mobile apps: iOS/Android field workflows using shared product model.
- Phase 8: Integrations: Flowspace and/or Teams notifications, handoffs, and workflow events.

---

## Next Steps

-> Resolve the three product questions above, then create a structured implementation plan in `docs/plans/` that splits this overhaul into reviewable phases and implementation units.
