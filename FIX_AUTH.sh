#!/bin/bash
# Fix PostgreSQL authentication to allow password auth for TCP connections

PG_HBA=$(sudo -u postgres psql -t -P format=unaligned -c 'SHOW hba_file;' 2>/dev/null | xargs)

if [ -z "$PG_HBA" ]; then
    # Try common locations
    for loc in /var/lib/pgsql/data/pg_hba.conf /var/lib/pgsql/*/data/pg_hba.conf; do
        if [ -f "$loc" ]; then
            PG_HBA="$loc"
            break
        fi
    done
fi

if [ -z "$PG_HBA" ] || [ ! -f "$PG_HBA" ]; then
    echo "❌ Could not find pg_hba.conf"
    echo "Please run: sudo find / -name pg_hba.conf 2>/dev/null"
    exit 1
fi

echo "Found pg_hba.conf at: $PG_HBA"
echo "Backing up..."
sudo cp "$PG_HBA" "$PG_HBA.backup.$(date +%s)"

echo "Updating to allow password authentication..."
# Update local connections
sudo sed -i 's/^local.*all.*all.*peer/local   all             all                                     md5/g' "$PG_HBA"
sudo sed -i 's/^local.*all.*all.*ident/local   all             all                                     md5/g' "$PG_HBA"

# Update IPv4 localhost
sudo sed -i 's/^host.*all.*all.*127.0.0.1\/32.*ident/host    all             all             127.0.0.1\/32            md5/g' "$PG_HBA"
sudo sed -i 's/^host.*all.*all.*127.0.0.1\/32.*peer/host    all             all             127.0.0.1\/32            md5/g' "$PG_HBA"

# Update IPv6 localhost
sudo sed -i 's/^host.*all.*all.*::1\/128.*ident/host    all             all             ::1\/128                 md5/g' "$PG_HBA"
sudo sed -i 's/^host.*all.*all.*::1\/128.*peer/host    all             all             ::1\/128                 md5/g' "$PG_HBA"

echo "Restarting PostgreSQL..."
sudo systemctl restart postgresql

echo "✅ Authentication fixed! PostgreSQL now accepts password authentication."
echo ""
echo "Test connection:"
echo "  PGPASSWORD=dev_password psql -U jwhite3321 -h localhost -d fsc_portal -c 'SELECT 1;'"
