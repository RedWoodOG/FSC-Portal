# Agent and contributor workspace

## Flutter field portal (canonical)

**Working directory for all Flutter development, analysis, tests, and Windows builds:**

`H:\FSC-Portal\FSC-Portal`

Run terminal commands from this path unless a task explicitly targets `server/`, `client/`, or another subproject at `H:\FSC-Portal`.

## Stable line (read-only for features)

`H:\FSC-Portal\Offline-Portal` — frozen MVP; do not implement new features here. Promote from `FSC-Portal` when ready. See `DEVELOPMENT_GUIDE.md`.

## Monorepo root

`H:\FSC-Portal` — Node server, other apps, and top-level docs.

## Connectivity (product intent)

**Offline-capable, not offline-only.** The app must work **local-first** (no network for core field workflows) and must **use the network when available** (sync, APIs, fleet integrations, updates) without breaking the disconnected experience. See `DEVELOPMENT_GUIDE.md` → *Connectivity model*.

## Near-term build order

**Ship hybrid offline + online and broader module updates first.** **Fleet / vehicle GPS** (telematics adapter, dispatcher map fed by company GPS) stays on the **roadmap** until there is **hands-on access** to the deployed stack and vendor/API details—not a prerequisite for current milestones.
