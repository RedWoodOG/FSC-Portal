# Quick Setup Guide - Fedora Native

## Step-by-Step Instructions

### 1. Navigate to Portal Directory

```bash
cd /home/jwhite3321/vyrevault-website/portal
```

### 2. Run Automated Setup (Recommended)

```bash
./setup-fedora-native.sh
```

This will install everything automatically.

### 3. OR Manual Setup

#### Install PostgreSQL and Redis

```bash
# Install PostgreSQL
sudo dnf install -y postgresql postgresql-server postgresql-contrib

# Initialize PostgreSQL
sudo postgresql-setup --initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Install Redis (optional)
sudo dnf install -y redis
sudo systemctl enable redis
sudo systemctl start redis
```

#### Create Database

```bash
sudo -u postgres psql <<EOF
CREATE USER vyrevault WITH PASSWORD 'vyrevault_dev';
CREATE DATABASE vyrevault_portal OWNER vyrevault;
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;
\q
EOF
```

#### Install Dependencies and Setup

```bash
cd server
npm install

# Create .env file
cat > .env <<'ENVEOF'
NODE_ENV=development
PORT=3001
DATABASE_URL=postgresql://vyrevault:vyrevault_dev@localhost:5432/vyrevault_portal
REDIS_URL=redis://localhost:6379
JWT_SECRET=$(openssl rand -hex 32)
JWT_EXPIRES_IN=7d
SESSION_SECRET=$(openssl rand -hex 32)
CORS_ORIGIN=http://localhost:3000
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10485760
FLO_API_URL=http://localhost:4000
A9N_API_URL=http://localhost:5000
LOG_LEVEL=info
ENVEOF

# Generate JWT secrets
JWT_SECRET=$(openssl rand -hex 32)
SESSION_SECRET=$(openssl rand -hex 32)
sed -i "s/\$(openssl rand -hex 32)/$JWT_SECRET/g" .env
sed -i "s/\$(openssl rand -hex 32)/$SESSION_SECRET/g" .env

# Setup database
npm run db:generate
npm run db:migrate
npm run db:seed
```

### 4. Start Development Server

```bash
npm run dev
```

API will be at: `http://localhost:3001`

### 5. Test It

```bash
# Health check
curl http://localhost:3001/health

# Login (get token)
curl -X POST http://localhost:3001/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@vyrevault.com","password":"admin123"}'
```

## Default Admin Credentials

- **Email**: `admin@vyrevault.com`
- **Password**: `admin123`

⚠️ Change these in production!

## Troubleshooting

### PostgreSQL not running
```bash
sudo systemctl status postgresql
sudo systemctl start postgresql
```

### Can't connect to database
```bash
# Check if database exists
sudo -u postgres psql -l | grep vyrevault_portal

# Test connection
psql -U vyrevault -d vyrevault_portal -h localhost
```

### Port 3001 in use
```bash
# Find what's using it
sudo lsof -i :3001

# Or change PORT in .env
```
