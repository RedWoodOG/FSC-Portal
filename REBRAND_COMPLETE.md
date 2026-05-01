# Rebranding Complete - Financial Systems Corp

## What Changed

All references to "VyreVault Studios" have been updated to "Financial Systems Corp" throughout the codebase.

### Updated Files

1. **Package Configuration**
   - `server/package.json` - Package name and description
   - Project name: `fsc-portal-server`

2. **Database Configuration**
   - Database name: `fsc_portal` (was `vyrevault_portal`)
   - Database user: `fsc_portal` (was `vyrevault`)
   - Database password: `fsc_portal_dev` (was `vyrevault_dev`)

3. **Code References**
   - `server/src/index.ts` - API messages
   - `server/prisma/schema.prisma` - Schema comments
   - `server/prisma/seed.ts` - Default admin email and portal name

4. **Documentation**
   - `README.md` - Project description
   - `server/README.md` - Backend documentation

5. **Setup Scripts**
   - `setup-fedora-native.sh` - Database names
   - `COMPLETE_DB_SETUP.sh` - Database setup
   - `fix-database-permissions.sh` - Permission fixes
   - `test-db-connection.sh` - Connection testing

6. **Docker Configuration**
   - `docker-compose.yml` - Container names and database config

### Default Admin Credentials

**Updated:**
- Email: `admin@financialsystemscorp.com`
- Password: `admin123`

### Database Connection String

**Updated:**
```
DATABASE_URL=postgresql://fsc_portal:fsc_portal_dev@localhost:5432/fsc_portal
```

## Next Steps

1. **Update your `.env` file** in `server/` directory:
   ```bash
   cd /home/jwhite3321/vyrevault-website/portal/server
   nano .env
   ```
   
   Update DATABASE_URL to:
   ```
   DATABASE_URL=postgresql://fsc_portal:fsc_portal_dev@localhost:5432/fsc_portal
   ```

2. **Run database setup**:
   ```bash
   cd /home/jwhite3321/vyrevault-website/portal
   bash COMPLETE_DB_SETUP.sh
   ```

3. **Continue with migrations**:
   ```bash
   cd server
   npm run db:migrate
   npm run db:seed
   npm run dev
   ```

## Project Context

This portal is designed for **Financial Systems Corp** - a banking equipment service company. The portal tracks:
- Branch locations (bank branches)
- Equipment per branch (ATMs, vault systems, cameras, etc.)
- Inventory and parts management
- Client relationships
- Service contracts and maintenance schedules
- Technician assignments and routing

This aligns with the original brainstorming document about building a dispatch and asset management system for the banking equipment service industry.
