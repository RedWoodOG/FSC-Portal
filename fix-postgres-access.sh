#!/bin/bash
# Fix PostgreSQL access for postgres user on fsc_portal database

echo "🔧 Fixing PostgreSQL access for postgres user..."

sudo -u postgres psql <<EOF
-- Grant all privileges on database to postgres user
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;

-- Connect to the database
\c fsc_portal

-- Grant schema privileges
GRANT ALL ON SCHEMA public TO postgres;

-- Grant privileges on all existing tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

-- Make postgres the owner
ALTER DATABASE fsc_portal OWNER TO postgres;

\q
EOF

echo "✅ Access granted to postgres user"

