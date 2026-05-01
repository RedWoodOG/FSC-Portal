import { Router, Request, Response, NextFunction } from 'express';
import { query, validationResult } from 'express-validator';
import { PrismaClient } from '@prisma/client';
import { authenticate } from '../middleware/auth.middleware';

const router = Router();
const prisma = new PrismaClient();

// All routes require authentication
router.use(authenticate);

/**
 * Get All Resources
 * GET /api/resources
 */
router.get(
  '/',
  [
    query('type').optional(),
    query('tags').optional(),
    query('page').optional().isInt({ min: 1 }),
    query('limit').optional().isInt({ min: 1, max: 100 })
  ],
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          error: 'Validation Error',
          details: errors.array()
        });
      }

      const page = parseInt(req.query.page as string) || 1;
      const limit = parseInt(req.query.limit as string) || 20;
      const skip = (page - 1) * limit;
      const type = req.query.type as string | undefined;
      const tags = req.query.tags as string | undefined;

      const where: any = {
        isActive: true
      };

      if (type) {
        where.type = {
          name: type
        };
      }

      if (tags) {
        const tagArray = tags.split(',');
        where.tags = {
          hasSome: tagArray
        };
      }

      const [resources, total] = await Promise.all([
        prisma.resource.findMany({
          where,
          skip,
          take: limit,
          include: {
            type: true,
            createdBy: {
              select: {
                id: true,
                name: true,
                email: true
              }
            },
            _count: {
              select: {
                versions: true
              }
            }
          },
          orderBy: {
            updatedAt: 'desc'
          }
        }),
        prisma.resource.count({ where })
      ]);

      res.json({
        resources,
        pagination: {
          page,
          limit,
          total,
          pages: Math.ceil(total / limit)
        }
      });
    } catch (error) {
      next(error);
    }
  }
);

/**
 * Get Resource by ID
 * GET /api/resources/:id
 */
router.get('/:id', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const resource = await prisma.resource.findUnique({
      where: { id: req.params.id },
      include: {
        type: true,
        createdBy: {
          select: {
            id: true,
            name: true,
            email: true
          }
        },
        versions: {
          orderBy: {
            createdAt: 'desc'
          }
        },
        dependencies: {
          include: {
            dependsOn: {
              select: {
                id: true,
                name: true,
                slug: true
              }
            }
          }
        }
      }
    });

    if (!resource) {
      return res.status(404).json({
        error: 'Not Found',
        message: 'Resource not found'
      });
    }

    // Increment usage count
    await prisma.resource.update({
      where: { id: resource.id },
      data: {
        usageCount: {
          increment: 1
        }
      }
    });

    res.json({ resource });
  } catch (error) {
    next(error);
  }
});

export default router;
