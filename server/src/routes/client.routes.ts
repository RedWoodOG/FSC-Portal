import { Router, Request, Response, NextFunction } from 'express';
import { PrismaClient } from '@prisma/client';
import { authenticate } from '../middleware/auth.middleware';

const router = Router();
const prisma = new PrismaClient();

// All routes require authentication
router.use(authenticate);

/**
 * Get All Clients
 * GET /api/clients
 */
router.get('/', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const clients = await prisma.client.findMany({
      include: {
        _count: {
          select: {
            projects: true,
            communications: true
          }
        },
        projects: {
          include: {
            project: {
              select: {
                id: true,
                name: true,
                status: true
              }
            }
          }
        }
      },
      orderBy: {
        name: 'asc'
      }
    });

    res.json({ clients });
  } catch (error) {
    next(error);
  }
});

/**
 * Get Client by ID
 * GET /api/clients/:id
 */
router.get('/:id', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const client = await prisma.client.findUnique({
      where: { id: req.params.id },
      include: {
        projects: {
          include: {
            project: {
              select: {
                id: true,
                name: true,
                status: true,
                healthScore: true
              }
            },
            milestones: {
              orderBy: {
                dueDate: 'asc'
              }
            }
          }
        },
        communications: {
          orderBy: {
            occurredAt: 'desc'
          },
          take: 10,
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true
              }
            }
          }
        }
      }
    });

    if (!client) {
      return res.status(404).json({
        error: 'Not Found',
        message: 'Client not found'
      });
    }

    res.json({ client });
  } catch (error) {
    next(error);
  }
});

export default router;
