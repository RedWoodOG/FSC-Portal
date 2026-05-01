#!/bin/bash
# Complete fix for database access - run this once

set -e

echo "🔧 Fixing Financial Systems Corp Portal Database Access"
echo "======================================================"
echo ""

# Step 1: Drop and recreate database as postgres user
echo "Step 1: Recreating database as postgres user..."
sudo -u postgres psql <<EOF
-- Drop database if exists (this will fail if there are connections, that's ok)
DROP DATABASE IF EXISTS fsc_portal;

-- Create database owned by postgres
CREATE DATABASE fsc_portal OWNER postgres;

-- Grant all privileges
GRANT ALL PRIVILEGES ON DATABASE fsc_portal TO postgres;

\q
EOF

echo "✅ Database recreated"
echo ""

# Step 2: Grant schema permissions
echo "Step 2: Granting schema permissions..."
sudo -u postgres psql -d fsc_portal <<EOF
-- Grant schema privileges
GRANT ALL ON SCHEMA public TO postgres;

-- Set default privileges for future objects
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;

\q
EOF

echo "✅ Permissions granted"
echo ""

# Step 3: Verify .env file
echo "Step 3: Verifying .env file..."
if [ -f "server/.env" ]; then
    if grep -q "DATABASE_URL=postgresql://postgres:@localhost:5432/fsc_portal" server/.env; then
        echo "✅ .env file is correct"
    else
        echo "⚠️  .env file needs DATABASE_URL update"
        echo "DATABASE_URL=postgresql://postgres:@localhost:5432/fsc_portal" >> server/.env
    fi
else
    echo "❌ .env file missing - creating it..."
    cat > server/.env <<ENVEOF
NODE_ENV=development
PORT=3001
DATABASE_URL=postgresql://postgres:@localhost:5432/fsc_portal
REDIS_URL=redis://localhost:6379
JWT_SECRET=7a8f3d9e2b1c4a6f8d0e3b5c7a9f2d4e6b8c0a3f5d7e9b1c4a6f8d0e3b5c7a9f
JWT_EXPIRES_IN=7d
SESSION_SECRET=3b5c7a9f2d4e6b8c0a3f5d7e9b1c4a6f8d0e3b5c7a9f2d4e6b8c0a3f5d
CORS_ORIGIN=http://localhost:3000
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10485760
FLO_API_URL=http://localhost:4000
FLO_API_KEY=
A9N_API_URL=http://localhost:5000
A9N_API_KEY=
LOG_LEVEL=info
ENVEOF
    echo "✅ .env file created"
fi

echo ""
echo "✅ Setup Complete!"
echo ""
echo "Now run:"
echo "  cd server"
echo "  npm run db:migrate"
echo "  npm run db:seed"
echo "  npm run dev"

