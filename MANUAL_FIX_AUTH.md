# Manual Fix for PostgreSQL Authentication

## The Problem
PostgreSQL is using "Ident" authentication for TCP connections, which blocks Prisma from connecting.

## The Solution

### Step 1: Find pg_hba.conf

```bash
sudo find / -name pg_hba.conf 2>/dev/null
```

Common locations:
- `/var/lib/pgsql/data/pg_hba.conf`
- `/var/lib/pgsql/*/data/pg_hba.conf`

### Step 2: Edit pg_hba.conf

```bash
sudo nano /var/lib/pgsql/data/pg_hba.conf
```

Find these lines:
```
local   all             all                                     peer
host    all             all             127.0.0.1/32            ident
host    all             all             ::1/128                 ident
```

Change them to:
```
local   all             all                                     md5
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
```

### Step 3: Restart PostgreSQL

```bash
sudo systemctl restart postgresql
```

### Step 4: Test Connection

```bash
PGPASSWORD=dev_password psql -U jwhite3321 -h 127.0.0.1 -d fsc_portal -c "SELECT 1;"
```

If this works, then run:
```bash
cd server
npm run db:migrate
npm run db:seed
npm run dev
```

## Alternative: Use postgres user

If you want to skip the auth fix, use the postgres user:

1. Update `.env`:
   ```
   DATABASE_URL=postgresql://postgres:@127.0.0.1:5432/fsc_portal
   ```

2. Grant permissions:
   ```bash
   sudo -u postgres psql -d fsc_portal -c "GRANT ALL ON SCHEMA public TO postgres;"
   ```

3. Run migrations:
   ```bash
   npm run db:migrate
   ```
