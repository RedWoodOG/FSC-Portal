#!/bin/bash
# ONE COMMAND TO FIX EVERYTHING
# Run: bash ONE_COMMAND_FIX.sh

sudo -u postgres psql <<'EOF'
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'fsc_portal' AND pid <> pg_backend_pid();
DROP DATABASE IF EXISTS fsc_portal;
CREATE DATABASE fsc_portal;
\c fsc_portal
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
GRANT ALL ON SCHEMA public TO postgres;
ALTER SCHEMA public OWNER TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TYPES TO PUBLIC;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;
SELECT 'Fixed' AS status;
EOF

echo "✅ Done! Now run: cd server && npm run db:migrate"
