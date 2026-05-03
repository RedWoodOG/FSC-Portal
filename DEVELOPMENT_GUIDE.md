# FSC Portal Development Guide

**Last Updated:** May 3, 2026

---

## Canonical working directory (Flutter app)

**All Flutter development and Windows builds use this folder only:**

`H:\FSC-Portal\FSC-Portal`

Open this path in your IDE, run `flutter pub get`, `flutter run`, and `flutter build` from here. Other copies (zip extracts, other drives) are not canonical unless you explicitly sync them into this tree.

**Monorepo root** (server, docs, scripts): `H:\FSC-Portal`

---

## Connectivity model (product intent)

**“Offline” names the lineage and the default posture (local-first), not an online ban.**

The field portal is meant to **run reliably without a network** for core workflows (local SQLite/Drift, maps and data on disk, capture while disconnected). It must **also** operate as a **connected** product when service is available: sync with backend or peers, authenticated APIs (e.g. fleet GPS), push/pull updates, and any cloud-assisted features you add—without making the **offline path** a second-class or broken experience.

Implementation guidance:

- **Design for offline-first**, then layer **optional online** enhancements with clear UX (what works offline vs needs connectivity). The Flutter shell (`FSC-Portal`) shows **Online/Offline** (network interface) and skips non-essential HTTP such as weather auto-fetch when offline—reuse that pattern for future sync.
- Avoid hard-coding assumptions that a tech always has signal, battery, or foreground app; vehicle/telematics and depot sync are examples of **online value-adds**, not replacements for local truth.
- Stable builds ship from **Offline-Portal** today; hybrid behavior should be specified and tested in **FSC-Portal** before promotion.

### Near-term engineering priority (2026)

**Now:** Prove **offline-capable** and **online/hybrid** paths together (local truth, sync/APIs when connected, clear UX for “needs network” vs air-gapped). **Update the rest of the program** (modules, wiring, UX consistency) around that spine—Landing Pad through operations, expenses, knowledge, etc., per `docs/brainstorms/`.

**Later (roadmap, not blocking current work):** **Fleet / vehicle GPS integration** and dispatcher map fed by **company telematics** wait until you can get **in front of the live system** and capture vendor/API, vehicle IDs, and mapping rules. Until then, keep GPS in **planning and competitive research only**; do not hard-schedule build work on unknown integration contracts.

---

## Project Structure Overview

```
H:\FSC-Portal\
│
├── Offline-Portal/          ← STABLE MVP (v1.0.0)
│   ├── Status: FROZEN
│   ├── Purpose: Production-ready deployment (local-first; must still support online/sync when configured)
│   ├── Database: portal_offline.sqlite
│   └── Build: portal_offline.exe
│
└── FSC-Portal/              ← DEVELOPMENT (v1.1.0+) — CANONICAL WORKDIR
    ├── Status: ACTIVE DEVELOPMENT
    ├── Purpose: Security features, improvements
    ├── Database: fsc_portal_dev.sqlite
    └── Build: fsc_portal.exe
```

---

## Working Philosophy

### The Golden Rule

**Never modify Offline-Portal directly.**

Always work in FSC-Portal. When features are stable and tested, you can choose to:
1. Keep them separate (two versions)
2. Merge back to Offline-Portal (single version)
3. Graduate FSC-Portal to production (FSC-Portal becomes new stable)

---

## Development Workflow

### Starting New Features

```powershell
# 1. Navigate to development branch
cd H:\FSC-Portal\FSC-Portal

# 2. Ensure clean state
flutter clean
flutter pub get

# 3. Run in debug mode
flutter run -d windows

# 4. Make changes
# ... edit files ...

# 5. Test changes
flutter analyze
flutter test

# 6. Build release if ready
flutter build windows --release
```

### Testing Database Changes

**Development database is isolated:**

- Location: `%USERPROFILE%\Documents\fsc_portal_dev.sqlite`
- Can be deleted/recreated without affecting stable version
- Schema changes only affect dev database

**To reset development database:**
```powershell
# Delete dev database (will recreate on next launch)
Remove-Item "$env:USERPROFILE\Documents\fsc_portal_dev.sqlite" -Force
```

### Merging Features Back to Stable

**Only when:**
1. Feature is complete and tested
2. No breaking changes to existing functionality
3. Performance impact measured and acceptable
4. Documentation updated

**Process:**
1. Document the changes
2. Test in FSC-Portal for 1+ week
3. Copy specific files (not entire directory)
4. Test again in Offline-Portal
5. Build and validate

---

## Current Development Focus

### Phase 1: Security Architecture

**Goals:**
1. Windows SID authentication (no passwords)
2. Hybrid encryption (derived key + stored key)
3. MKPE provenance tracking (audit trail)
4. Key backup/recovery system

**Files to be modified:**
- `lib/database/app_database.dart` - Add encryption
- `lib/services/auth_service.dart` - New file for Windows auth
- `lib/services/encryption_service.dart` - New file for key management
- `lib/services/provenance_service.dart` - New file for MKPE
- `lib/main.dart` - Wire up auth + encryption

**Timeline:** 2-3 days for Phase 1 implementation

---

## Safety Checklist

Before making major changes:

- [ ] Am I in FSC-Portal directory? (not Offline-Portal)
- [ ] Have I tested in development first?
- [ ] Is Offline-Portal still untouched?
- [ ] Can I rollback if this breaks?
- [ ] Have I documented what changed?

---

## Database Migration Strategy

### For Development (FSC-Portal)

Schema changes are safe - development database is isolated.

### For Stable (Offline-Portal)

**Only migrate schema when:**
1. Feature is proven in dev
2. Migration is tested and reversible
3. Data backup exists
4. Users are notified

---

## Build Artifacts

### Development Builds

```
FSC-Portal/build/windows/x64/runner/Release/fsc_portal.exe
```

- Different name from stable build
- Can coexist on same machine
- Uses different database file

### Stable Builds

```
Offline-Portal/build/windows/x64/runner/Release/portal_offline.exe
```

- Production-ready
- Should only be rebuilt from Offline-Portal directory
- Never overwrite with untested dev builds

---

## Version Control Recommendations

**If using Git:**

```bash
# From H:\FSC-Portal\FSC-Portal
git init
git add .
git commit -m "Initial commit - cloned from Offline-Portal v1.0.0"

# Create development branch
git checkout -b feature/security-architecture
```

**Branch strategy:**
- `main` - Stable (matches Offline-Portal)
- `develop` - Active development
- `feature/*` - Specific features

---

## Questions & Answers

**Q: Can I run both versions at the same time?**  
A: Yes! They use different executables and different databases.

**Q: What if I accidentally modify Offline-Portal?**  
A: You still have the original build artifacts. Worst case, re-clone from FSC-Portal.

**Q: When should I graduate FSC-Portal to production?**  
A: When security features are complete, tested, and you're ready to retire Offline-Portal.

**Q: Can I delete the Offline-Portal directory?**  
A: Not yet. Keep it until FSC-Portal is proven stable in production.

---

## Emergency Procedures

### If FSC-Portal breaks completely

```powershell
# 1. Delete broken FSC-Portal
Remove-Item H:\FSC-Portal\FSC-Portal -Recurse -Force

# 2. Re-clone from stable
xcopy "H:\FSC-Portal\Offline-Portal" "H:\FSC-Portal\FSC-Portal" /E /I /H /Y

# 3. Restart development
cd H:\FSC-Portal\FSC-Portal
flutter pub get
```

### If you need to rollback changes

```powershell
# If using Git
git checkout main  # or specific commit

# If not using Git
# Re-clone from Offline-Portal (see above)
```

---

## Success Metrics

**FSC-Portal is ready for production when:**

✅ All Phase 1 security features implemented  
✅ Tested with 2-3 pilot users for 1+ week  
✅ No critical bugs reported  
✅ Performance is comparable to v1.0.0  
✅ Documentation complete  
✅ Recovery procedures tested  

---

**Good luck building! Remember: Offline-Portal is your safety net.**
