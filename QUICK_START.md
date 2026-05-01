# VyreVault Studios Portal - Quick Start Guide

## Overview

This guide will help you get the VyreVault Studios Company Portal up and running quickly for development.

## Prerequisites

Before starting, ensure you have:

- **Node.js** 18+ installed
- **PostgreSQL** 14+ installed and running
- **Redis** 6+ installed and running (optional but recommended)
- **Git** for version control

## Quick Setup

### 1. Clone and Navigate

```bash
cd /home/jwhite3321/vyrevault-website/portal
```

### 2. Install Dependencies

```bash
# Install root dependencies
npm install

# Install client dependencies
cd client && npm install && cd ..

# Install server dependencies
cd server && npm install && cd ..
```

### 3. Database Setup

```bash
# Create PostgreSQL database
createdb vyrevault_portal

# Run schema
psql vyrevault_portal < database/schema.sql

# Or use migration tool (when implemented)
cd server && npm run db:migrate
```

### 4. Environment Configuration

```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your configuration
nano .env  # or use your preferred editor
```

**Required environment variables:**
- `DATABASE_URL`: PostgreSQL connection string
- `JWT_SECRET`: Secret key for JWT tokens
- `SESSION_SECRET`: Secret key for sessions

**Optional but recommended:**
- `REDIS_URL`: Redis connection string
- `FLO_API_URL`: FLŌ integration endpoint
- `A9N_API_URL`: A9n integration endpoint

### 5. Start Development Servers

```bash
# Start both client and server
npm run dev

# Or start separately:
# Terminal 1: Client (usually port 3000)
npm run dev:client

# Terminal 2: Server (usually port 3001)
npm run dev:server
```

### 6. Access the Portal

- **Client**: http://localhost:3000
- **API**: http://localhost:3001
- **API Docs**: http://localhost:3001/api/docs (when implemented)

## Initial Setup Tasks

### Create Admin User

Once the database is set up, create your first admin user:

```sql
-- Insert admin user (password: 'admin123' - CHANGE THIS!)
-- Use bcrypt to hash your actual password
INSERT INTO users (email, password_hash, name, role) VALUES
  ('admin@vyrevault.com', '$2b$10$...', 'Admin User', 'admin');
```

Or use the seed script (when implemented):
```bash
npm run db:seed
```

### Seed Initial Data

```sql
-- Resource types are already seeded in schema.sql
-- Add some test projects, resources, etc. as needed
```

## Development Workflow

### Making Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Client code: `client/src/`
   - Server code: `server/src/`
   - Database: `database/migrations/`

3. **Test your changes**
   ```bash
   npm test
   ```

4. **Commit and push**
   ```bash
   git add .
   git commit -m "Add: your feature description"
   git push origin feature/your-feature-name
   ```

### Code Structure

```
portal/
├── client/              # Frontend React app
│   ├── src/
│   │   ├── components/ # Reusable components
│   │   ├── pages/      # Page components
│   │   ├── hooks/      # Custom React hooks
│   │   ├── utils/      # Utility functions
│   │   └── styles/     # CSS/styling
│   └── package.json
├── server/             # Backend Express app
│   ├── src/
│   │   ├── routes/     # API routes
│   │   ├── models/     # Data models
│   │   ├── middleware/ # Express middleware
│   │   └── services/   # Business logic
│   └── package.json
├── database/           # Database files
│   ├── schema.sql      # Full schema
│   ├── migrations/     # Migration files
│   └── seeds/          # Seed data
└── docs/              # Documentation
```

## Common Tasks

### Database Migrations

```bash
# Create a new migration
cd server && npm run db:migrate:create migration_name

# Run migrations
npm run db:migrate

# Rollback last migration
npm run db:rollback
```

### Running Tests

```bash
# All tests
npm test

# Client tests only
npm run test:client

# Server tests only
npm run test:server

# Watch mode
npm run test:watch
```

### Linting

```bash
# Check for issues
npm run lint

# Auto-fix issues
npm run lint:fix
```

### Building for Production

```bash
# Build everything
npm run build

# Build client only
npm run build:client

# Build server only
npm run build:server
```

## Troubleshooting

### Database Connection Issues

```bash
# Check PostgreSQL is running
sudo systemctl status postgresql

# Test connection
psql -U your_user -d vyrevault_portal -c "SELECT 1;"
```

### Port Already in Use

```bash
# Find process using port
lsof -i :3000
lsof -i :3001

# Kill process
kill -9 <PID>
```

### Module Not Found Errors

```bash
# Clear node_modules and reinstall
rm -rf node_modules client/node_modules server/node_modules
npm install
cd client && npm install && cd ..
cd server && npm install && cd ..
```

### Database Schema Issues

```bash
# Reset database (WARNING: Deletes all data!)
npm run db:reset

# Re-run migrations
npm run db:migrate
```

## Next Steps

1. **Review Architecture**: Read [ARCHITECTURE.md](./ARCHITECTURE.md)
2. **Implementation Plan**: Check [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md)
3. **UI Concepts**: See [UI_CONCEPT.md](./UI_CONCEPT.md)
4. **Start Development**: Begin with Phase 1 tasks

## Getting Help

- Check documentation in `/docs` folder
- Review code comments
- Check GitHub issues (when repository is set up)
- Contact the development team

## Development Tips

1. **Use TypeScript**: Type safety prevents many bugs
2. **Write Tests**: Especially for critical business logic
3. **Follow Conventions**: Keep code consistent with existing patterns
4. **Document Changes**: Update docs when adding features
5. **Small Commits**: Commit often with clear messages

## Environment-Specific Notes

### Fedora Linux

Since you're on Fedora, here are some helpful commands:

```bash
# Install PostgreSQL
sudo dnf install postgresql postgresql-server
sudo postgresql-setup --initdb
sudo systemctl enable postgresql
sudo systemctl start postgresql

# Install Redis
sudo dnf install redis
sudo systemctl enable redis
sudo systemctl start redis

# Install Node.js (if not already installed)
sudo dnf install nodejs npm
```

---

**Happy Coding! 🚀**
