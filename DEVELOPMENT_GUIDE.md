# FSC Portal Development Guide

**Last Updated:** January 30, 2026

---

## Project Structure Overview

```
h:\FSC_Portal\
│
├── Offline-Portal/          ← STABLE MVP (v1.0.0)
│   ├── Status: FROZEN
│   ├── Purpose: Production-ready deployment
│   ├── Database: portal_offline.sqlite
│   └── Build: portal_offline.exe
│
└── FSC-Portal/              ← DEVELOPMENT (v1.1.0+)
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
cd h:\FSC_Portal\FSC-Portal

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
# From h:\FSC_Portal\FSC-Portal
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
Remove-Item h:\FSC_Portal\FSC-Portal -Recurse -Force

# 2. Re-clone from stable
xcopy "h:\FSC_Portal\Offline-Portal" "h:\FSC_Portal\FSC-Portal" /E /I /H /Y

# 3. Restart development
cd h:\FSC_Portal\FSC-Portal
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
