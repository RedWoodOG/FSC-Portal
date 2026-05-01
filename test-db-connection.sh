#!/bin/bash
# Test database connection and permissions

echo "🔍 Testing database connection..."
echo ""

# Test 1: Check if user exists
echo "1. Checking if fsc_portal user exists..."
sudo -u postgres psql -c "\du" | grep fsc_portal && echo "   ✅ User exists" || echo "   ❌ User does NOT exist"

echo ""
echo "2. Checking if database exists..."
sudo -u postgres psql -c "\l" | grep fsc_portal && echo "   ✅ Database exists" || echo "   ❌ Database does NOT exist"

echo ""
echo "3. Testing connection as fsc_portal user..."
PGPASSWORD=fsc_portal_dev psql -U fsc_portal -d fsc_portal -h localhost -c "SELECT 1;" 2>&1 && echo "   ✅ Connection successful" || echo "   ❌ Connection failed"

echo ""
echo "4. Checking PostgreSQL authentication method..."
echo "   Current pg_hba.conf settings:"
sudo grep -E "^local|^host" /var/lib/pgsql/data/pg_hba.conf 2>/dev/null | head -5 || echo "   (Could not read pg_hba.conf)"

echo ""
echo "📝 If connection failed, you may need to:"
echo "   1. Create the user: sudo -u postgres psql -c \"CREATE USER fsc_portal WITH PASSWORD 'fsc_portal_dev';\""
echo "   2. Update pg_hba.conf to allow password authentication"
echo "   3. Restart PostgreSQL: sudo systemctl restart postgresql"
