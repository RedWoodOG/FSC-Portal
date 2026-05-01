# Financial Systems Corp Portal - Setup Guide

## Location
`/run/media/jwhite3321/New Volume1/FSC_Portal`

## What's Included

✅ **Complete Node.js Backend**
- Express server with TypeScript
- Prisma ORM with PostgreSQL schema
- JWT authentication & RBAC
- All API routes (auth, projects, resources, team, clients)
- Health checks and audit logging

✅ **Full Documentation**
- Architecture documentation
- Implementation plans
- Setup guides
- Troubleshooting guides

✅ **Database Schemas**
- Prisma schema (server/prisma/schema.prisma)
- SQL schema (database/schema.sql)

✅ **Setup Scripts**
- Database setup scripts
- Permission fix scripts
- Fedora native setup

## Quick Start

### 1. Install Dependencies

```bash
cd "/run/media/jwhite3321/New Volume1/FSC_Portal/server"
npm install
```

### 2. Configure Environment

```bash
# Copy .env from original location
cp /home/jwhite3321/vyrevault-website/portal/server/.env "/run/media/jwhite3321/New Volume1/FSC_Portal/server/.env"

# Or create new one
cp .env.example .env
nano .env  # Edit with your database credentials
```

### 3. Setup Database

```bash
# Generate Prisma client
npm run db:generate

# Run migrations
npm run db:migrate

# Seed database
npm run db:seed
```

### 4. Start Server

```bash
npm run dev
```

API will be available at: `http://localhost:3001`

## Database Configuration

Default connection (update in `.env`):
```
DATABASE_URL=postgresql://jwhite3321:dev_password@127.0.0.1:5432/fsc_portal
```

## Default Admin

- Email: `admin@financialsystemscorp.com`
- Password: `admin123`

⚠️ Change these in production!

## Project Structure

```
FSC_Portal/
├── server/              # Backend API
│   ├── src/
│   │   ├── routes/     # API endpoints
│   │   └── middleware/ # Auth, error handling, audit
│   ├── prisma/         # Database schema
│   └── package.json
├── database/           # SQL schemas
└── docs/              # Documentation
```

## Next Steps

1. Install dependencies: `cd server && npm install`
2. Configure `.env` file
3. Setup database: `npm run db:migrate`
4. Start development: `npm run dev`

## Original Location

Original project: `/home/jwhite3321/vyrevault-website/portal`

This is a complete backup copy with all source code, dependencies, and documentation.
