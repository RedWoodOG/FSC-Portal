#!/bin/bash
# Complete fix - removes all restrictions and fixes authentication

echo "🔓 Complete Database Fix - Removing ALL Restrictions"
echo "===================================================="
echo ""

# Step 1: Fix database permissions
sudo -u postgres psql <<'DB_FIX'
-- Terminate connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

-- Drop and recreate
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal;

\c fsc_portal

-- Remove ALL restrictions
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
ALTER SCHEMA public OWNER TO postgres;

-- Grant everything to PUBLIC
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO PUBLIC;

-- Database level
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;

SELECT 'Database permissions fixed' AS status;
\q
DB_FIX

echo "✅ Database permissions fixed"
echo ""

# Step 2: Fix pg_hba.conf to allow password authentication
PG_HBA="/var/lib/pgsql/data/pg_hba.conf"
if [ -f "$PG_HBA" ]; then
    echo "Fixing PostgreSQL authentication (pg_hba.conf)..."
    
    # Backup
    sudo cp "$PG_HBA" "$PG_HBA.backup"
    
    # Update local connections to use md5 (password auth)
    sudo sed -i 's/^local.*all.*all.*peer/local   all             all                                     md5/g' "$PG_HBA"
    sudo sed -i 's/^local.*all.*all.*ident/local   all             all                                     md5/g' "$PG_HBA"
    
    # Update IPv4 localhost connections
    sudo sed -i 's/^host.*all.*all.*127.0.0.1\/32.*ident/host    all             all             127.0.0.1\/32            md5/g' "$PG_HBA"
    sudo sed -i 's/^host.*all.*all.*127.0.0.1\/32.*peer/host    all             all             127.0.0.1\/32            md5/g' "$PG_HBA"
    
    # If no local line exists, add it
    if ! sudo grep -q "^local.*all.*all" "$PG_HBA"; then
        sudo sed -i '/^# TYPE/a local   all             all                                     md5' "$PG_HBA"
    fi
    
    # Restart PostgreSQL
    echo "Restarting PostgreSQL..."
    sudo systemctl restart postgresql
    
    echo "✅ Authentication fixed"
else
    echo "⚠️  Could not find pg_hba.conf - authentication may need manual fix"
fi

echo ""
echo "✅ Complete fix applied!"
echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"
