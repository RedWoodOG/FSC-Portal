#!/bin/bash
# Fix PostgreSQL permissions for vyrevault user

echo "🔧 Fixing database permissions..."

sudo -u postgres psql <<EOF
-- Grant all privileges on database
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO fsc_portal;

-- Connect to the database and grant schema privileges
\c fsc_portal

-- Grant privileges on schema
GRANT ALL ON SCHEMA public TO fsc_portal;

-- Grant privileges on all existing tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO fsc_portal;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO fsc_portal;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO fsc_portal;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO fsc_portal;

\q
EOF

echo "✅ Permissions fixed!"
