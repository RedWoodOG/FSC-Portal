# Final Fix Instructions

## The Problem
PostgreSQL is denying access to the `fsc_portal` database because the schema permissions aren't set correctly.

## The Solution

**Run this ONE command:**

```bash
cd /home/jwhite3321/vyrevault-website/portal
bash RUN_THIS_TO_FIX.sh
```

This script will:
1. Drop and recreate the database with proper ownership
2. Fix all schema permissions
3. Grant postgres user full access

You'll be prompted for your sudo password once.

## After Running the Fix

```bash
cd server
npm run db:migrate
npm run db:seed
npm run dev
```

## If It Still Doesn't Work

Check PostgreSQL authentication method:

```bash
sudo grep "^local\|^host" /var/lib/pgsql/data/pg_hba.conf | head -5
```

If it shows `peer` instead of `md5`, update it:

```bash
sudo nano /var/lib/pgsql/data/pg_hba.conf
```

Change:
```
local   all             all                                     peer
```

To:
```
local   all             all                                     md5
```

Then restart PostgreSQL:
```bash
sudo systemctl restart postgresql
```

## Your .env File

Your `.env` file is already configured correctly:
```
DATABASE_URL=postgresql://postgres:@localhost:5432/fsc_portal
```

The fix script will make sure the database is accessible with these credentials.

