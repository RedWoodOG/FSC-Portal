#!/bin/bash
# RUN THIS - It creates the user and fixes ALL permissions
# bash RUN_ME_NOW.sh

sudo -u postgres psql <<'EOF'
-- Create user if doesn't exist
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_user WHERE usename = 'jwhite3321') THEN
        CREATE USER jwhite3321;
        ALTER USER jwhite3321 CREATEDB;
        ALTER USER jwhite3321 WITH SUPERUSER;
    ELSE
        ALTER USER jwhite3321 CREATEDB;
        ALTER USER jwhite3321 WITH SUPERUSER;
    END IF;
END
$$;

-- Fix database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'fsc_portal'
  AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal OWNER jwhite3321;

\c fsc_portal

-- Remove ALL restrictions
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO jwhite3321;
GRANT ALL ON SCHEMA public TO postgres;
ALTER SCHEMA public OWNER TO jwhite3321;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO PUBLIC;

GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO jwhite3321;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;

SELECT 'FIXED - Database is now completely open' AS status;
EOF

echo ""
echo "✅ DONE! Now run:"
echo "  cd server"
echo "  npm run db:migrate"
