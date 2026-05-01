#!/bin/bash
# ULTIMATE FIX - Run this ONCE and it fixes everything
# Usage: bash ULTIMATE_FIX.sh

set -e

echo "🔧 ULTIMATE FIX - Financial Systems Corp Portal"
echo "================================================"
echo ""

# Step 1: Create PostgreSQL user matching system user (for peer auth)
echo "Step 1: Creating PostgreSQL user for peer authentication..."
sudo -u postgres psql <<'EOF'
-- Create user matching system user if it doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'jwhite3321') THEN
        CREATE USER jwhite3321;
        ALTER USER jwhite3321 CREATEDB;
    END IF;
END
$$;
EOF

# Step 2: Fix database permissions
echo ""
echo "Step 2: Fixing database permissions..."
sudo -u postgres psql <<'EOF'
-- Terminate connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

-- Drop and recreate
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal OWNER jwhite3321;

-- Connect and fix schema
\c fsc_portal

-- Remove ALL restrictions
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO jwhite3321;
GRANT ALL ON SCHEMA public TO postgres;
ALTER SCHEMA public OWNER TO jwhite3321;

-- Grant everything
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TYPES TO PUBLIC;

-- Database level
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO jwhite3321;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;

SELECT 'Database fixed' AS status;
\q
EOF

# Step 3: Update .env to use system user
echo ""
echo "Step 3: Updating .env file..."
cd server
sed -i 's|DATABASE_URL=.*|DATABASE_URL=postgresql://jwhite3321@/fsc_portal|g' .env
echo "✅ .env updated"

echo ""
echo "✅ ULTIMATE FIX COMPLETE!"
echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"
echo "  npm run db:seed"
echo "  npm run dev"
