import { Router, Request, Response, NextFunction } from 'express';
import { PrismaClient } from '@prisma/client';
import { authenticate } from '../middleware/auth.middleware';

const router = Router();
const prisma = new PrismaClient();

// All routes require authentication
router.use(authenticate);

/**
 * Get All Team Members
 * GET /api/team
 */
router.get('/', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const users = await prisma.user.findMany({
      where: {
        isActive: true
      },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        avatarUrl: true,
        teamProfile: {
          select: {
            bio: true,
            skills: true,
            expertiseAreas: true,
            availabilityStatus: true
          }
        },
        presenceLog: {
          select: {
            status: true,
            lastSeen: true
          }
        },
        _count: {
          select: {
            ownedProjects: true,
            projectMembers: true
          }
        }
      },
      orderBy: {
        name: 'asc'
      }
    });

    res.json({ team: users });
  } catch (error) {
    next(error);
  }
});

/**
 * Get Team Member by ID
 * GET /api/team/:id
 */
router.get('/:id', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: req.params.id },
      select: {
        id: true,
        name: true,
        email: true,
        role: true,
        avatarUrl: true,
        createdAt: true,
        teamProfile: true,
        presenceLog: true,
        ownedProjects: {
          select: {
            id: true,
            name: true,
            status: true
          }
        },
        projectMembers: {
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
      }
    });

    if (!user) {
      return res.status(404).json({
        error: 'Not Found',
        message: 'Team member not found'
      });
    }

    res.json({ member: user });
  } catch (error) {
    next(error);
  }
});

export default router;
