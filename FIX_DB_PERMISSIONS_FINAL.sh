#!/bin/bash
# Final fix for PostgreSQL permissions - fixes everything

set -e

echo "🔧 Final Database Permission Fix"
echo "================================="
echo ""

# Connect as postgres and fix everything
sudo -u postgres psql <<'SQL'
-- First, terminate any existing connections to the database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

-- Drop the database completely
DROP DATABASE IF EXISTS fsc_portal;

-- Create it fresh as postgres user
CREATE DATABASE fsc_portal OWNER postgres;

-- Connect to the new database
\c fsc_portal

-- Grant everything to postgres (should already be owner, but ensure it)
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;

-- Set default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

-- Verify
SELECT 'Database fsc_portal created and owned by postgres' AS status;
\q
SQL

echo ""
echo "✅ Database recreated with proper permissions"
echo ""
echo "Testing connection..."
if psql -U postgres -d fsc_portal -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Connection test successful!"
else
    echo "⚠️  Connection test failed - checking pg_hba.conf..."
    echo "You may need to update PostgreSQL authentication settings"
fi

echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"

