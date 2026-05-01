# Native Fedora Setup (No Docker)

This guide sets up the VyreVault Portal backend on Fedora Linux without using Docker containers.

## Quick Setup

Run the automated setup script:

```bash
cd /home/jwhite3321/vyrevault-website/portal
./setup-fedora-native.sh
```

The script will:
1. Install PostgreSQL and Redis (if not already installed)
2. Create the database and user
3. Install Node.js dependencies
4. Set up environment variables
5. Run database migrations
6. Seed initial data

## Manual Setup

If you prefer to set up manually:

### 1. Install System Packages

```bash
# Install PostgreSQL
sudo dnf install -y postgresql postgresql-server postgresql-contrib

# Initialize and start PostgreSQL
sudo postgresql-setup --initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Install Redis (optional but recommended)
sudo dnf install -y redis
sudo systemctl enable redis
sudo systemctl start redis

# Install Node.js (if not already installed)
sudo dnf install -y nodejs npm
```

### 2. Create Database

```bash
# Switch to postgres user
sudo -u postgres psql

# In PostgreSQL prompt:
CREATE USER vyrevault WITH PASSWORD 'vyrevault_dev';
CREATE DATABASE vyrevault_portal OWNER vyrevault;
GRANT ALL PRIVILEGES ON DATABASE vyrevault_portal TO vyrevault;
\q
```

### 3. Install Dependencies

```bash
cd /home/jwhite3321/vyrevault-website/portal/server
npm install
```

### 4. Configure Environment

```bash
cp .env.example .env
# Edit .env with your database credentials
```

Update the `DATABASE_URL` in `.env`:
```
DATABASE_URL=postgresql://vyrevault:vyrevault_dev@localhost:5432/vyrevault_portal
```

### 5. Set Up Database Schema

```bash
# Generate Prisma client
npm run db:generate

# Run migrations
npm run db:migrate

# Seed initial data
npm run db:seed
```

### 6. Start Development Server

```bash
npm run dev
```

The API will be available at `http://localhost:3001`

## Verify Installation

### Check PostgreSQL

```bash
# Check if PostgreSQL is running
sudo systemctl status postgresql

# Test connection
psql -U vyrevault -d vyrevault_portal -h localhost
```

### Check Redis

```bash
# Check if Redis is running
sudo systemctl status redis

# Test connection
redis-cli ping
# Should return: PONG
```

### Test API

```bash
# Health check
curl http://localhost:3001/health

# Should return JSON with status: "healthy"
```

## Default Credentials

After seeding:
- **Email**: `admin@vyrevault.com`
- **Password**: `admin123`

⚠️ **Change these immediately in production!**

## Troubleshooting

### PostgreSQL Connection Issues

```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Check PostgreSQL logs
sudo journalctl -u postgresql -f

# Verify database exists
sudo -u postgres psql -l | grep vyrevault_portal
```

### Permission Issues

If you get permission errors:
```bash
# Fix PostgreSQL authentication (edit pg_hba.conf)
sudo nano /var/lib/pgsql/data/pg_hba.conf

# Change this line:
# local   all             all                                     peer
# To:
# local   all             all                                     md5

# Restart PostgreSQL
sudo systemctl restart postgresql
```

### Port Already in Use

If port 3001 is already in use:
```bash
# Find process using port
sudo lsof -i :3001

# Kill process
kill -9 <PID>

# Or change PORT in .env file
```

## Service Management

### Start Services

```bash
sudo systemctl start postgresql
sudo systemctl start redis
```

### Stop Services

```bash
sudo systemctl stop postgresql
sudo systemctl stop redis
```

### Enable Auto-Start

```bash
sudo systemctl enable postgresql
sudo systemctl enable redis
```

## Next Steps

Once the backend is running:

1. Test the API endpoints
2. Set up the frontend (Next.js)
3. Configure integrations (FLŌ, A9n)

See the main [README.md](./README.md) for more information.
