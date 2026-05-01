# Fix Database Permissions - Manual Steps

## The Issue
The `vyrevault` user doesn't have proper permissions on the `vyrevault_portal` database.

## Solution

Run these commands in your terminal:

### Option 1: Quick Fix (Recommended)

```bash
sudo -u postgres psql <<EOF
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;
\c vyrevault_portal
GRANT ALL ON SCHEMA public TO vyrevault;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO vyrevault;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO vyrevault;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO vyrevault;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO vyrevault;
\q
EOF
```

### Option 2: Step by Step

```bash
# 1. Connect to PostgreSQL as postgres user
sudo -u postgres psql

# 2. Grant database privileges
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;

# 3. Connect to the database
\c vyrevault_portal

# 4. Grant schema privileges
GRANT ALL ON SCHEMA public TO vyrevault;

# 5. Grant privileges on existing tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO vyrevault;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO vyrevault;

# 6. Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO vyrevault;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO vyrevault;

# 7. Exit
\q
```

### Option 3: If User Doesn't Exist

If the `vyrevault` user doesn't exist, create it first:

```bash
sudo -u postgres psql <<EOF
CREATE USER vyrevault WITH PASSWORD 'vyrevault_dev';
CREATE DATABASE vyrevault_portal OWNER vyrevault;
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;
\c vyrevault_portal
GRANT ALL ON SCHEMA public TO vyrevault;
\q
EOF
```

## Verify It Works

After running the fix, test the connection:

```bash
cd /home/jwhite3321/vyrevault-website/portal/server
npm run db:migrate
```

If it works, you should see migration output instead of permission errors.

## Alternative: Use postgres User

If you want to use the `postgres` user instead (for development only):

1. Update `.env`:
   ```
   DATABASE_URL=postgresql://postgres:your_postgres_password@localhost:5432/vyrevault_portal
   ```

2. Create database:
   ```bash
   sudo -u postgres psql -c "CREATE DATABASE vyrevault_portal;"
   ```

This is simpler but less secure (not recommended for production).
