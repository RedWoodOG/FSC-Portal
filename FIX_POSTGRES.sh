#!/bin/bash
# Complete PostgreSQL fix - run this with: bash FIX_POSTGRES.sh

echo "🔧 Fixing PostgreSQL Database Access"
echo "===================================="
echo ""

# Run as postgres user to fix everything
sudo -u postgres bash <<'POSTGRES_SCRIPT'
set -e

echo "Connected as postgres user"
echo ""

# Terminate any existing connections
echo "Step 1: Terminating existing connections..."
psql -c "
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();
" 2>/dev/null || echo "No active connections to terminate"

# Drop and recreate database
echo ""
echo "Step 2: Dropping and recreating database..."
psql -c "DROP DATABASE IF EXISTS fsc_portal;" 2>/dev/null || true
psql -c "CREATE DATABASE fsc_portal OWNER postgres;"
psql -c "GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;"

# Connect to database and fix schema
echo ""
echo "Step 3: Fixing schema permissions..."
psql -d fsc_portal <<'SCHEMA_FIX'
-- Grant schema privileges
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;

-- Set default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

-- Make postgres owner of public schema
ALTER SCHEMA public OWNER TO postgres;

-- Verify
SELECT 'Schema permissions fixed' AS status;
SCHEMA_FIX

echo ""
echo "✅ Database setup complete!"
echo ""
echo "Testing connection..."
psql -d fsc_portal -c "SELECT 'Connection successful!' AS test;" || echo "Connection test failed"

POSTGRES_SCRIPT

echo ""
echo "✅ Fix complete!"
echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"

