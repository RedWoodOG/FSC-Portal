# Financial Systems Corp Portal

Complete copy of the Financial Systems Corp Company Portal project.

## Location
`/run/media/jwhite3321/New Volume1/FSC_Portal`

## Project Structure

```
FSC_Portal/
├── server/              # Node.js + Express + Prisma backend
│   ├── src/            # TypeScript source code
│   │   ├── routes/     # API routes
│   │   └── middleware/ # Express middleware
│   ├── prisma/         # Database schema
│   └── package.json
├── database/           # SQL schemas
├── docs/              # Documentation
└── scripts/           # Setup scripts
```

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
# Edit .env with your database credentials
```

### 3. Setup Database

```bash
npm run db:generate
npm run db:migrate
npm run db:seed
```

### 4. Start Server

```bash
npm run dev
```

API will be available at: `http://localhost:3001`

## Default Admin

- Email: `admin@financialsystemscorp.com`
- Password: `admin123`

## Original Location

Original project: `/home/jwhite3321/vyrevault-website/portal`

This is a complete backup copy.
