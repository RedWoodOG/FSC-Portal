import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import dotenv from 'dotenv';
import { PrismaClient } from '@prisma/client';

// Routes
import authRoutes from './routes/auth.routes';
import projectRoutes from './routes/project.routes';
import resourceRoutes from './routes/resource.routes';
import teamRoutes from './routes/team.routes';
import clientRoutes from './routes/client.routes';
import healthRoutes from './routes/health.routes';

// Middleware
import { errorHandler } from './middleware/error.middleware';
import { auditLogger } from './middleware/audit.middleware';

// Load environment variables
dotenv.config();

const app = express();
const prisma = new PrismaClient();
const PORT = process.env.PORT || 3001;

// =====================================================
// Middleware
// =====================================================

// Security
app.use(helmet());

// CORS
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  credentials: true
}));

// Body parsing
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Logging
if (process.env.NODE_ENV !== 'test') {
  app.use(morgan('combined'));
}

// Audit logging
app.use(auditLogger);

// =====================================================
// Routes
// =====================================================

// Health check (no auth required)
app.use('/health', healthRoutes);

// Authentication routes
app.use('/api/auth', authRoutes);

// Protected routes (require authentication)
app.use('/api/projects', projectRoutes);
app.use('/api/resources', resourceRoutes);
app.use('/api/team', teamRoutes);
app.use('/api/clients', clientRoutes);

// Root
app.get('/', (req, res) => {
  res.json({
    message: 'Financial Systems Corp Portal API',
    version: '0.1.0',
    status: 'operational'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.method} ${req.path} not found`
  });
});

// Error handler (must be last)
app.use(errorHandler);

// =====================================================
// Server Startup
// =====================================================

const server = app.listen(PORT, () => {
  console.log(`🚀 Financial Systems Corp Portal API running on port ${PORT}`);
  console.log(`📊 Environment: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🔗 Health check: http://localhost:${PORT}/health`);
});

// Graceful shutdown
process.on('SIGTERM', async () => {
  console.log('SIGTERM received, shutting down gracefully...');
  server.close(async () => {
    await prisma.$disconnect();
    console.log('Server closed, database disconnected');
    process.exit(0);
  });
});

process.on('SIGINT', async () => {
  console.log('SIGINT received, shutting down gracefully...');
  server.close(async () => {
    await prisma.$disconnect();
    console.log('Server closed, database disconnected');
    process.exit(0);
  });
});

export default app;
