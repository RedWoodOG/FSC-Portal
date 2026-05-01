# Financial Systems Corp Portal - Backend API

Node.js + Express + PostgreSQL + Prisma backend for the Financial Systems Corp Company Portal.

## Quick Start

### Prerequisites
- Node.js 18+
- PostgreSQL 14+ (or use Docker Compose)
- npm or yarn

### Setup

1. **Install dependencies**
   ```bash
   npm install
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Start PostgreSQL** (if using Docker Compose)
   ```bash
   cd ..
   docker-compose up -d postgres redis
   ```

4. **Set up database**
   ```bash
   # Generate Prisma client
   npm run db:generate

   # Run migrations
   npm run db:migrate

   # Seed initial data
   npm run db:seed
   ```

5. **Start development server**
   ```bash
   npm run dev
   ```

The API will be available at `http://localhost:3001`

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login
- `GET /api/auth/me` - Get current user
- `POST /api/auth/logout` - Logout

### Projects
- `GET /api/projects` - List all projects (with pagination)
- `GET /api/projects/:id` - Get project details
- `POST /api/projects` - Create project (requires DEVELOPER+)
- `PATCH /api/projects/:id` - Update project (requires MANAGER+)
- `DELETE /api/projects/:id` - Delete project (requires ADMIN)

### Resources
- `GET /api/resources` - List all resources (with pagination, filtering)
- `GET /api/resources/:id` - Get resource details

### Team
- `GET /api/team` - List all team members
- `GET /api/team/:id` - Get team member details

### Clients
- `GET /api/clients` - List all clients
- `GET /api/clients/:id` - Get client details

### Health
- `GET /health` - Health check
- `GET /health/ready` - Readiness check
- `GET /health/live` - Liveness check

## Authentication

All protected routes require a JWT token in the Authorization header:

```
Authorization: Bearer <token>
```

## Role-Based Access Control

- **ADMIN**: Full access
- **MANAGER**: Project management, client management
- **DEVELOPER**: Project creation, resource management
- **VIEWER**: Read-only access

## Database

### Prisma Commands

```bash
# Generate Prisma Client
npm run db:generate

# Create migration
npm run db:migrate

# Push schema changes (dev only)
npm run db:push

# Open Prisma Studio (database GUI)
npm run db:studio

# Reset database (WARNING: deletes all data)
npm run db:reset
```

## Development

```bash
# Start with hot reload
npm run dev

# Build for production
npm run build

# Run production build
npm start

# Run tests
npm test

# Lint code
npm run lint
```

## Project Structure

```
server/
├── src/
│   ├── index.ts              # Entry point
│   ├── routes/               # API routes
│   │   ├── auth.routes.ts
│   │   ├── project.routes.ts
│   │   ├── resource.routes.ts
│   │   ├── team.routes.ts
│   │   ├── client.routes.ts
│   │   └── health.routes.ts
│   └── middleware/           # Express middleware
│       ├── auth.middleware.ts
│       ├── error.middleware.ts
│       └── audit.middleware.ts
├── prisma/
│   ├── schema.prisma         # Database schema
│   └── seed.ts               # Seed data
└── package.json
```

## Environment Variables

See `.env.example` for all required environment variables.

Key variables:
- `DATABASE_URL` - PostgreSQL connection string
- `JWT_SECRET` - Secret for JWT token signing
- `PORT` - Server port (default: 3001)
- `CORS_ORIGIN` - Allowed CORS origin

## Default Admin User

After seeding:
- Email: `admin@vyrevault.com`
- Password: `admin123`

**⚠️ Change this immediately in production!**
