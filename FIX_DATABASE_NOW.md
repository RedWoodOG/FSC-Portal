# Fix Database Permissions - Simple Solution

The issue: PostgreSQL 18 has tighter default permissions. Your user can't create tables.

## Solution: Use postgres superuser for development

**Edit `server\.env` line 1:**

Change from:
```
DATABASE_URL=postgresql://jwhite3321:dev_password@127.0.0.1:5432/fsc_portal
```

To:
```
DATABASE_URL=postgresql://postgres:YOUR_POSTGRES_PASSWORD@127.0.0.1:5432/fsc_portal
```

Replace `YOUR_POSTGRES_PASSWORD` with the postgres password you set during PostgreSQL installation.

Then run:
```powershell
cd server
node node_modules\prisma\build\index.js db push
```

This is YOUR development machine. Using the postgres superuser is fine.

## Alternative: Fix the user password

If you want to use `jwhite3321`, you need to either:
1. Know the postgres password to grant permissions, OR
2. Reset the jwhite3321 password in PostgreSQL to match `.env`

For development on your own workstation, just use `postgres` user. Simple.
