#!/bin/bash
# Find and fix PostgreSQL authentication

echo "🔧 Fixing PostgreSQL Authentication"
echo "===================================="
echo ""

# Find pg_hba.conf
PG_HBA=""
for loc in \
    "/var/lib/pgsql/data/pg_hba.conf" \
    "/var/lib/pgsql/*/data/pg_hba.conf" \
    "$(sudo -u postgres psql -t -P format=unaligned -c 'SHOW hba_file;' 2>/dev/null | xargs)"; do
    if [ -f "$loc" ]; then
        PG_HBA="$loc"
        break
    fi
done

# Try to find it
if [ -z "$PG_HBA" ]; then
    PG_HBA=$(sudo find /var/lib -name "pg_hba.conf" 2>/dev/null | head -1)
fi

if [ -z "$PG_HBA" ] || [ ! -f "$PG_HBA" ]; then
    echo "❌ Could not find pg_hba.conf automatically"
    echo ""
    echo "Please find it manually:"
    echo "  sudo find / -name pg_hba.conf 2>/dev/null"
    echo ""
    echo "Then edit it and change 'peer' or 'ident' to 'md5' for:"
    echo "  - local connections"
    echo "  - 127.0.0.1/32 connections"
    echo "  - ::1/128 connections"
    echo ""
    echo "Then restart: sudo systemctl restart postgresql"
    exit 1
fi

echo "Found: $PG_HBA"
echo "Backing up..."
sudo cp "$PG_HBA" "$PG_HBA.backup.$(date +%s)"

echo "Updating authentication method..."
# Change peer/ident to md5 for local and localhost connections
sudo sed -i 's/^\(local.*all.*all.*\)peer$/\1md5/g' "$PG_HBA"
sudo sed -i 's/^\(local.*all.*all.*\)ident$/\1md5/g' "$PG_HBA"
sudo sed -i 's/^\(host.*all.*all.*127\.0\.0\.1\/32.*\)ident$/\1md5/g' "$PG_HBA"
sudo sed -i 's/^\(host.*all.*all.*127\.0\.0\.1\/32.*\)peer$/\1md5/g' "$PG_HBA"
sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)ident$/\1md5/g' "$PG_HBA"
sudo sed -i 's/^\(host.*all.*all.*::1\/128.*\)peer$/\1md5/g' "$PG_HBA"

echo "Restarting PostgreSQL..."
sudo systemctl restart postgresql
sleep 2

echo ""
echo "✅ Authentication fixed!"
echo ""
echo "Testing connection..."
if PGPASSWORD=dev_password psql -U jwhite3321 -h localhost -d fsc_portal -c "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Connection test successful!"
    echo ""
    echo "Now run:"
    echo "  cd server"
    echo "  npm run db:migrate"
else
    echo "⚠️  Connection test failed"
    echo "Check pg_hba.conf manually"
fi
