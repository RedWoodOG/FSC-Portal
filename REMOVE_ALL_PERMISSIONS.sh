#!/bin/bash
# Remove ALL permission restrictions - makes database completely open

echo "🔓 Removing ALL Permission Restrictions"
echo "========================================="
echo ""

sudo -u postgres psql <<'EOF'
-- Terminate all connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

-- Drop and recreate database
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal;

-- Connect to database
\c fsc_portal

-- Remove ALL restrictions from public schema
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;

-- Make postgres owner
ALTER SCHEMA public OWNER TO postgres;

-- Grant everything to PUBLIC (all users)
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO PUBLIC;

-- Also grant to postgres specifically
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

-- Grant database-level permissions
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;

-- Remove any existing ACL restrictions
REVOKE ALL ON DATABASE fsc_portal FROM PUBLIC;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;

-- Verify
SELECT 'Database is now completely open - no permission restrictions' AS status;
\q
EOF

echo ""
echo "✅ All permission restrictions removed!"
echo ""
echo "Database is now completely open for development."
echo ""
echo "Run:"
echo "  cd server"
echo "  npm run db:migrate"
