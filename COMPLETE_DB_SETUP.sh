#!/bin/bash
# Complete database setup script
# Run this with: bash COMPLETE_DB_SETUP.sh

set -e

echo "🚀 Complete Database Setup for Financial Systems Corp Portal"
echo "================================================"
echo ""

DB_USER="fsc_portal"
DB_PASSWORD="fsc_portal_dev"
DB_NAME="fsc_portal"

echo "Step 1: Creating PostgreSQL user and database..."
sudo -u postgres psql <<EOF
-- Create user if not exists
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_user WHERE usename = '$DB_USER') THEN
        CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
        RAISE NOTICE 'User $DB_USER created';
    ELSE
        RAISE NOTICE 'User $DB_USER already exists';
    END IF;
END
\$\$;

-- Create database if not exists
SELECT 'CREATE DATABASE $DB_NAME OWNER $DB_USER'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$DB_NAME')\gexec

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
\q
EOF

echo "✅ User and database created"
echo ""

echo "Step 2: Granting schema permissions..."
sudo -u postgres psql -d $DB_NAME <<EOF
-- Grant schema privileges
GRANT ALL ON SCHEMA public TO $DB_USER;

-- Grant privileges on all existing tables (if any)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO $DB_USER;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO $DB_USER;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO $DB_USER;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO $DB_USER;

\q
EOF

echo "✅ Permissions granted"
echo ""

echo "Step 3: Checking PostgreSQL authentication..."
PG_HBA="/var/lib/pgsql/data/pg_hba.conf"

if [ -f "$PG_HBA" ]; then
    echo "Checking pg_hba.conf for local connections..."
    
    # Check if there's a local connection line that allows password auth
    if ! sudo grep -q "^local.*all.*all.*md5" "$PG_HBA" && ! sudo grep -q "^local.*all.*all.*password" "$PG_HBA"; then
        echo "⚠️  WARNING: PostgreSQL may be using 'peer' authentication for local connections"
        echo "   This means you need to connect as the postgres user, not vyrevault"
        echo ""
        echo "   Option 1: Update pg_hba.conf to use md5 (password) authentication"
        echo "   Option 2: Use postgres user in DATABASE_URL (development only)"
        echo ""
    else
        echo "✅ Password authentication appears to be configured"
    fi
else
    echo "⚠️  Could not find pg_hba.conf at $PG_HBA"
fi

echo ""
echo "Step 4: Testing connection..."
if PGPASSWORD=$DB_PASSWORD psql -U $DB_USER -d $DB_NAME -h localhost -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Connection test successful!"
else
    echo "❌ Connection test failed"
    echo ""
    echo "This might be due to PostgreSQL authentication settings."
    echo "Try using the postgres user instead:"
    echo ""
    echo "  Update .env DATABASE_URL to:"
    echo "  DATABASE_URL=postgresql://postgres:@localhost:5432/$DB_NAME"
    echo ""
    echo "Or update pg_hba.conf to allow password authentication"
fi

echo ""
echo "✅ Database setup complete!"
echo ""
echo "Next steps:"
echo "  cd server"
echo "  npm run db:migrate"
echo "  npm run db:seed"
echo "  npm run dev"
