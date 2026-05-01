# Database Permission Troubleshooting

## The Problem

You're getting: `User 'vyrevault' was denied access on the database 'vyrevault_portal.public'`

This usually means one of:
1. User doesn't exist
2. User exists but lacks permissions
3. PostgreSQL authentication method (pg_hba.conf) is blocking the connection

## Solution 1: Run Complete Setup Script

```bash
cd /home/jwhite3321/vyrevault-website/portal
bash COMPLETE_DB_SETUP.sh
```

This will create the user, database, and grant all necessary permissions.

## Solution 2: Manual Fix

### Step 1: Create User and Database

```bash
sudo -u postgres psql <<EOF
CREATE USER vyrevault WITH PASSWORD 'vyrevault_dev';
CREATE DATABASE vyrevault_portal OWNER vyrevault;
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;
\q
EOF
```

### Step 2: Grant Schema Permissions

```bash
sudo -u postgres psql -d vyrevault_portal <<EOF
GRANT ALL ON SCHEMA public TO vyrevault;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO vyrevault;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO vyrevault;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO vyrevault;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO vyrevault;
\q
EOF
```

### Step 3: Fix Authentication (if needed)

If you still get permission errors, PostgreSQL might be using "peer" authentication instead of password authentication.

**Check current settings:**
```bash
sudo grep "^local" /var/lib/pgsql/data/pg_hba.conf
```

**If it shows `peer` instead of `md5` or `password`:**

1. Edit pg_hba.conf:
   ```bash
   sudo nano /var/lib/pgsql/data/pg_hba.conf
   ```

2. Find the line:
   ```
   local   all             all                                     peer
   ```

3. Change it to:
   ```
   local   all             all                                     md5
   ```

4. Also check for IPv4 connections:
   ```
   host    all             all             127.0.0.1/32            md5
   ```

5. Restart PostgreSQL:
   ```bash
   sudo systemctl restart postgresql
   ```

## Solution 3: Use postgres User (Development Only)

If you want to skip the authentication issues for development:

1. Update `.env` in `server/` directory:
   ```bash
   cd /home/jwhite3321/vyrevault-website/portal/server
   nano .env
   ```

2. Change DATABASE_URL to:
   ```
   DATABASE_URL=postgresql://postgres:@localhost:5432/vyrevault_portal
   ```
   (Add password if postgres user has one)

3. Create database:
   ```bash
   sudo -u postgres psql -c "CREATE DATABASE vyrevault_portal;"
   ```

4. Continue with migrations:
   ```bash
   npm run db:migrate
   npm run db:seed
   ```

## Test Connection

After setup, test the connection:

```bash
# Test as vyrevault user
PGPASSWORD=vyrevault_dev psql -U vyrevault -d vyrevault_portal -h localhost -c "SELECT 1;"

# Or test as postgres user
psql -U postgres -d vyrevault_portal -c "SELECT 1;"
```

## Verify Setup

Run the test script:

```bash
cd /home/jwhite3321/vyrevault-website/portal
./test-db-connection.sh
```

This will show you exactly what's missing.

## Common Issues

### Issue: "peer authentication failed"
**Fix:** Update pg_hba.conf to use `md5` instead of `peer` (see Solution 2, Step 3)

### Issue: "password authentication failed"
**Fix:** Make sure the password in `.env` matches the user password in PostgreSQL

### Issue: "database does not exist"
**Fix:** Create the database:
```bash
sudo -u postgres psql -c "CREATE DATABASE vyrevault_portal;"
```

### Issue: "permission denied for schema public"
**Fix:** Grant schema permissions (see Solution 2, Step 2)
