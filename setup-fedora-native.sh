#!/bin/bash
# VyreVault Portal - Native Fedora Setup (No Docker)
# This script sets up PostgreSQL and Redis natively on Fedora

set -e

echo "🚀 Financial Systems Corp Portal - Native Fedora Setup"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if running as root for system package installation
if [ "$EUID" -eq 0 ]; then 
   echo -e "${RED}Please run this script as a regular user (not root)${NC}"
   exit 1
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if service is running
service_running() {
    systemctl is-active --quiet "$1"
}

echo "📦 Step 1: Checking prerequisites..."
echo ""

# Check Node.js
if ! command_exists node; then
    echo -e "${YELLOW}Node.js not found. Installing...${NC}"
    sudo dnf install -y nodejs npm
else
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}✓ Node.js found: $NODE_VERSION${NC}"
fi

# Check PostgreSQL
if ! command_exists psql; then
    echo -e "${YELLOW}PostgreSQL not found. Installing...${NC}"
    sudo dnf install -y postgresql postgresql-server postgresql-contrib
    echo -e "${YELLOW}Initializing PostgreSQL database...${NC}"
    sudo postgresql-setup --initdb
    sudo systemctl enable postgresql
    sudo systemctl start postgresql
    echo -e "${GREEN}✓ PostgreSQL installed and started${NC}"
else
    echo -e "${GREEN}✓ PostgreSQL found${NC}"
    if ! service_running postgresql; then
        echo -e "${YELLOW}Starting PostgreSQL...${NC}"
        sudo systemctl start postgresql
        sudo systemctl enable postgresql
    fi
fi

# Check Redis (optional but recommended)
if ! command_exists redis-cli; then
    echo -e "${YELLOW}Redis not found. Installing...${NC}"
    sudo dnf install -y redis
    sudo systemctl enable redis
    sudo systemctl start redis
    echo -e "${GREEN}✓ Redis installed and started${NC}"
else
    echo -e "${GREEN}✓ Redis found${NC}"
    if ! service_running redis; then
        echo -e "${YELLOW}Starting Redis...${NC}"
        sudo systemctl start redis
        sudo systemctl enable redis
    fi
fi

echo ""
echo "🗄️  Step 2: Setting up PostgreSQL database..."
echo ""

# Create database and user
DB_NAME="fsc_portal"
DB_USER="fsc_portal"
DB_PASSWORD="fsc_portal_dev"

echo "Creating database and user..."
sudo -u postgres psql <<EOF
-- Create user if not exists
DO \$\$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_user WHERE usename = '$DB_USER') THEN
        CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
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

echo -e "${GREEN}✓ Database created${NC}"

echo ""
echo "📦 Step 3: Installing Node.js dependencies..."
echo ""

cd "$(dirname "$0")/server"

if [ ! -f "package.json" ]; then
    echo -e "${RED}Error: package.json not found in server directory${NC}"
    exit 1
fi

npm install
echo -e "${GREEN}✓ Dependencies installed${NC}"

echo ""
echo "⚙️  Step 4: Setting up environment variables..."
echo ""

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${GREEN}✓ Created .env from .env.example${NC}"
    else
        echo -e "${YELLOW}Creating .env file...${NC}"
        cat > .env <<EOF
# Server Configuration
NODE_ENV=development
PORT=3001

# Database (Native PostgreSQL)
DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME

# Redis (Native Redis)
REDIS_URL=redis://localhost:6379

# Authentication
JWT_SECRET=$(openssl rand -hex 32)
JWT_EXPIRES_IN=7d
SESSION_SECRET=$(openssl rand -hex 32)

# CORS
CORS_ORIGIN=http://localhost:3000

# File Storage
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10485760

# External Integrations
FLO_API_URL=http://localhost:4000
FLO_API_KEY=
A9N_API_URL=http://localhost:5000
A9N_API_KEY=

# Logging
LOG_LEVEL=info
EOF
        echo -e "${GREEN}✓ Created .env file${NC}"
    fi
else
    echo -e "${YELLOW}.env file already exists, skipping...${NC}"
fi

echo ""
echo "🗄️  Step 5: Setting up database schema..."
echo ""

# Generate Prisma client
npm run db:generate
echo -e "${GREEN}✓ Prisma client generated${NC}"

# Run migrations
npm run db:migrate
echo -e "${GREEN}✓ Database migrations completed${NC}"

# Seed database
npm run db:seed
echo -e "${GREEN}✓ Database seeded${NC}"

echo ""
echo "✅ Setup Complete!"
echo "=================="
echo ""
echo "Next steps:"
echo "  1. Start the development server:"
echo "     cd portal/server && npm run dev"
echo ""
echo "  2. Default admin credentials:"
echo "     Email: admin@vyrevault.com"
echo "     Password: admin123"
echo ""
echo "  3. API will be available at: http://localhost:3001"
echo ""
