# Financial Systems Corp Portal

Complete copy of the Financial Systems Corp Company Portal project.

## Canonical paths (authoritative)

| What | Path |
| :--- | :--- |
| **Flutter app — build and run here** | `H:\FSC-Portal\FSC-Portal` |
| **Stable / frozen MVP (do not develop new features here)** | `H:\FSC-Portal\Offline-Portal` |
| **Monorepo root** (server, client, docs) | `H:\FSC-Portal` |

Details: `DEVELOPMENT_GUIDE.md` at repo root.

**Connectivity:** The field app is **local-first / offline-capable** (must run core workflows without a network) and **hybrid** (sync, backend, and integrations when online). “Offline” in naming reflects that posture, not a refusal to connect.

## Location (legacy reference only)

`/run/media/jwhite3321/New Volume1/FSC_Portal` — superseded by `H:\FSC-Portal` on this machine.

## Project Structure

```
H:\FSC-Portal\
├── FSC-Portal/          # Flutter field app — CANONICAL WORKDIR
├── Offline-Portal/      # Frozen stable Flutter line
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
cd "H:\FSC-Portal\server"
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
