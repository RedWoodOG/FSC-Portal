#!/bin/bash
# Force fix database permissions - drops and recreates everything

set -e

echo "🔧 Force Fixing Database Permissions"
echo "===================================="
echo ""

# Kill any existing connections
echo "Step 1: Terminating existing connections..."
sudo -u postgres psql <<EOF
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();
\q
EOF

echo "✅ Connections terminated"
echo ""

# Drop and recreate database
echo "Step 2: Dropping and recreating database..."
sudo -u postgres psql <<EOF
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal OWNER postgres;
\q
EOF

echo "✅ Database recreated"
echo ""

# Grant all permissions
echo "Step 3: Granting all permissions..."
sudo -u postgres psql -d fsc_portal <<EOF
-- Grant schema privileges
GRANT ALL ON SCHEMA public TO postgres;

-- Make postgres owner of public schema
ALTER SCHEMA public OWNER TO postgres;

-- Set default privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;

-- Verify
SELECT current_user, current_database();
\q
EOF

echo "✅ All permissions granted"
echo ""
echo "✅ Database is ready!"
echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"

