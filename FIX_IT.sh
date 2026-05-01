#!/bin/bash
# ONE COMMAND TO FIX EVERYTHING
# Run: bash FIX_IT.sh

echo "🔧 Fixing Everything..."
echo ""

# Find pg_hba.conf
PG_HBA=$(sudo find /var/lib -name "pg_hba.conf" 2>/dev/null | head -1)

if [ -n "$PG_HBA" ] && [ -f "$PG_HBA" ]; then
    echo "Found pg_hba.conf: $PG_HBA"
    sudo cp "$PG_HBA" "$PG_HBA.backup"
    sudo sed -i 's/peer$/md5/g' "$PG_HBA"
    sudo sed -i 's/ident$/md5/g' "$PG_HBA"
    sudo systemctl restart postgresql
    echo "✅ Authentication fixed"
else
    echo "⚠️  pg_hba.conf not found - you may need to edit manually"
fi

# Fix database
psql -d fsc_portal <<'EOF'
GRANT ALL ON SCHEMA public TO jwhite3321;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
ALTER SCHEMA public OWNER TO jwhite3321;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO jwhite3321;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO PUBLIC;
EOF

echo "✅ Done! Run: cd server && npm run db:migrate"
