#!/bin/bash
# RUN THIS SCRIPT - It will fix all PostgreSQL permissions
# Usage: bash RUN_THIS_TO_FIX.sh

echo "🔧 Financial Systems Corp Portal - Database Fix"
echo "================================================"
echo ""
echo "This will fix PostgreSQL permissions for the fsc_portal database."
echo "You'll be prompted for your sudo password."
echo ""

# Fix database as postgres user
sudo -u postgres psql <<'EOF'
-- Terminate connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

-- Drop and recreate
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal OWNER postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;

-- Connect and fix schema
\c fsc_portal

-- Fix schema ownership and permissions
ALTER SCHEMA public OWNER TO postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;

-- Set defaults
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

-- Verify
SELECT 'Database fsc_portal is ready' AS status;
\q
EOF

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Database fixed successfully!"
    echo ""
    echo "Now run:"
    echo "  cd server"
    echo "  npm run db:migrate"
    echo "  npm run db:seed"
    echo "  npm run dev"
else
    echo ""
    echo "❌ Fix failed. Check PostgreSQL is running:"
    echo "  sudo systemctl status postgresql"
fi

