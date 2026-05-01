#!/bin/bash
# COMPLETE FIX - Run this once, fixes everything
# bash COMPLETE_FIX.sh

set -e

echo "🔧 COMPLETE FIX - Financial Systems Corp Portal"
echo "=================================================="
echo ""

# Step 1: Find and fix pg_hba.conf
echo "Step 1: Finding and fixing PostgreSQL authentication..."

PG_HBA=""
# Try to get location from PostgreSQL
PG_HBA=$(sudo -u postgres psql -t -P format=unaligned -c "SHOW hba_file;" 2>/dev/null | xargs 2>/dev/null || echo "")

# If not found, try common locations
if [ -z "$PG_HBA" ] || [ ! -f "$PG_HBA" ]; then
    for loc in /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/*/data/pg_hba.conf; do
        if [ -f "$loc" ]; then
            PG_HBA="$loc"
            break
        fi
    done
fi

# Last resort - search
if [ -z "$PG_HBA" ] || [ ! -f "$PG_HBA" ]; then
    PG_HBA=$(sudo find /var/lib -name "pg_hba.conf" 2>/dev/null | head -1)
fi

if [ -n "$PG_HBA" ] && [ -f "$PG_HBA" ]; then
    echo "Found: $PG_HBA"
    echo "Backing up..."
    sudo cp "$PG_HBA" "$PG_HBA.backup.$(date +%s)"
    
    echo "Updating authentication to md5..."
    sudo sed -i 's/^\(local.*all.*all.*\)peer$/\1md5/g' "$PG_HBA"
    sudo sed -i 's/^\(local.*all.*all.*\)ident$/\1md5/g' "$PG_HBA"
    sudo sed -i 's/^\(host.*all.*all.*127\.0\.0\.1\/32.*\)ident$/\1md5/g' "$PG_HBA"
    sudo sed -i 's/^\(host.*all.*all.*127\.0\.0\.1\/32.*\)peer$/\1md5/g' "$PG_HBA"
    sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)ident$/\1md5/g' "$PG_HBA"
    sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)peer$/\1md5/g' "$PG_HBA"
    
    echo "Restarting PostgreSQL..."
    sudo systemctl restart postgresql
    sleep 2
    echo "✅ Authentication fixed"
else
    echo "⚠️  Could not find pg_hba.conf automatically"
    echo "You'll need to edit it manually (see MANUAL_FIX_AUTH.md)"
fi

# Step 2: Fix database permissions
echo ""
echo "Step 2: Fixing database permissions..."
psql -d fsc_portal <<'EOF'
GRANT USAGE ON SCHEMA public TO jwhite3321;
GRANT CREATE ON SCHEMA public TO jwhite3321;
GRANT ALL ON SCHEMA public TO jwhite3321;
GRANT ALL ON SCHEMA public TO PUBLIC;
ALTER SCHEMA public OWNER TO jwhite3321;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO PUBLIC;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO jwhite3321;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;
SELECT 'Permissions fixed' AS status;
EOF

echo "✅ Database permissions fixed"

# Step 3: Verify connection
echo ""
echo "Step 3: Testing connection..."
if PGPASSWORD=dev_password psql -U jwhite3321 -h 127.0.0.1 -d fsc_portal -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Connection test successful!"
    echo ""
    echo "✅ COMPLETE FIX DONE!"
    echo ""
    echo "Now run:"
    echo "  cd server"
    echo "  npm run db:migrate"
    echo "  npm run db:seed"
    echo "  npm run dev"
else
    echo "⚠️  Connection test failed"
    echo "You may need to manually edit pg_hba.conf (see MANUAL_FIX_AUTH.md)"
    echo "Or the authentication fix didn't apply - check PostgreSQL logs"
fi
