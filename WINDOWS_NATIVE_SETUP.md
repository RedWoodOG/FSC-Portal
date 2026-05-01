# FSC Portal - Native Windows Setup

**CONFIRMED:** System running on **NATIVE WINDOWS POSTGRESQL** - NO DOCKER

## ✅ Current Configuration

### Database
- **PostgreSQL 18** - Native Windows service
- **Service Name:** `postgresql-x64-18`
- **Status:** Running
- **Port:** 5432
- **Connection:** `postgresql://jwhite3321:dev_password@127.0.0.1:5432/fsc_portal`

### Backend
- **Node.js:** v25.1.0
- **TypeScript:** tsx for execution
- **Port:** 3001
- **Status:** Build-ready

## 🚀 Starting the System

### Quick Start
```powershell
.\Start-Dev.ps1
```

This will:
1. Check PostgreSQL Windows service is running
2. Test database connectivity
3. Launch backend server on port 3001

### Manual Control

**Start PostgreSQL:**
```powershell
Start-Service postgresql-x64-18
```

**Stop PostgreSQL:**
```powershell
Stop-Service postgresql-x64-18
```

**Start Server Only:**
```powershell
.\Start-Dev.ps1 -SkipDatabase
```

## 🔧 Database Setup

First-time setup (if database doesn't exist):
```powershell
.\setup\Setup-Database.ps1
```

This creates:
- Database: `fsc_portal`
- User: `jwhite3321` with password `dev_password`
- Applies Prisma schema

## 📝 Files Created (Native Windows)

- `Verify-System.ps1` - System diagnostics (checks native PostgreSQL)
- `Start-Dev.ps1` - Startup script (uses native PostgreSQL)
- `setup\Setup-Database.ps1` - Database initialization (native PostgreSQL)
- `WINDOWS_NATIVE_SETUP.md` - This file

## ❌ Files NOT Used

- `docker-compose.yml` - **IGNORE** (Docker not used)
- All `.sh` bash scripts - **DELETE** (Linux only)

## 🎯 System Status

**Backend:** ✅ WORKING  
**Database:** ✅ NATIVE WINDOWS POSTGRESQL  
**Docker:** ❌ NOT USED

## Next Steps

1. ✅ Native PostgreSQL configured and running
2. ✅ Backend launches successfully
3. ⏭️ Test API endpoints (http://localhost:3001/health)
4. ⏭️ Begin FSC Portal refactoring per plan:
   - Brand assets (FSC logos)
   - Service architecture split
   - Windows service wrappers
   - Remove VyreVault references
   - Delete all bash scripts

---
**Platform:** Native Windows  
**Database:** PostgreSQL 18 Windows Service  
**No Docker Required**
