import { Router, Request, Response, NextFunction } from 'express';
import { body, query, validationResult } from 'express-validator';
import { PrismaClient } from '@prisma/client';
import { authenticate, authorize } from '../middleware/auth.middleware';
import { createError } from '../middleware/error.middleware';

const router = Router();
const prisma = new PrismaClient();

// All routes require authentication
router.use(authenticate);

/**
 * Get All Projects
 * GET /api/projects
 */
router.get(
  '/',
  [
    query('status').optional().isIn(['PLANNING', 'ACTIVE', 'ON_HOLD', 'COMPLETED', 'ARCHIVED']),
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
      const status = req.query.status as string | undefined;
      const skip = (page - 1) * limit;

      const where: any = {};
      if (status) {
        where.status = status;
      }

      const [projects, total] = await Promise.all([
        prisma.project.findMany({
          where,
          skip,
          take: limit,
          include: {
            owner: {
              select: {
                id: true,
                name: true,
                email: true
              }
            },
            members: {
              include: {
                user: {
                  select: {
                    id: true,
                    name: true,
                    email: true
                  }
                }
              }
            },
            _count: {
              select: {
                milestones: true
              }
            }
          },
          orderBy: {
            updatedAt: 'desc'
          }
        }),
        prisma.project.count({ where })
      ]);

      res.json({
        projects,
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
 * Get Project by ID
 * GET /api/projects/:id
 */
router.get('/:id', async (req: Request, res: Response, next: NextFunction) => {
  try {
    const project = await prisma.project.findUnique({
      where: { id: req.params.id },
      include: {
        owner: {
          select: {
            id: true,
            name: true,
            email: true
          }
        },
        members: {
          include: {
            user: {
              select: {
                id: true,
                name: true,
                email: true,
                avatarUrl: true
              }
            }
          }
        },
        milestones: {
          orderBy: {
            dueDate: 'asc'
          }
        },
        clientProjects: {
          include: {
            client: {
              select: {
                id: true,
                name: true
              }
            }
          }
        }
      }
    });

    if (!project) {
      return res.status(404).json({
        error: 'Not Found',
        message: 'Project not found'
      });
    }

    res.json({ project });
  } catch (error) {
    next(error);
  }
});

/**
 * Create Project
 * POST /api/projects
 */
router.post(
  '/',
  authorize('ADMIN', 'MANAGER', 'DEVELOPER'),
  [
    body('name').trim().notEmpty(),
    body('description').optional().trim(),
    body('status').optional().isIn(['PLANNING', 'ACTIVE', 'ON_HOLD', 'COMPLETED', 'ARCHIVED'])
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

      const { name, description, status = 'PLANNING', repositoryUrl, documentationUrl } = req.body;

      // Generate slug from name
      const slug = name
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/(^-|-$)/g, '');

      const project = await prisma.project.create({
        data: {
          name,
          slug,
          description,
          status: status as any,
          ownerId: req.user!.id,
          repositoryUrl,
          documentationUrl
        },
        include: {
          owner: {
            select: {
              id: true,
              name: true,
              email: true
            }
          }
        }
      });

      res.status(201).json({
        message: 'Project created successfully',
        project
      });
    } catch (error) {
      next(error);
    }
  }
);

/**
 * Update Project
 * PATCH /api/projects/:id
 */
router.patch(
  '/:id',
  authorize('ADMIN', 'MANAGER'),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { id } = req.params;
      const updateData = req.body;

      // Check if project exists
      const existingProject = await prisma.project.findUnique({
        where: { id }
      });

      if (!existingProject) {
        return res.status(404).json({
          error: 'Not Found',
          message: 'Project not found'
        });
      }

      // Check permissions (owner or admin)
      if (existingProject.ownerId !== req.user!.id && req.user!.role !== 'ADMIN') {
        return res.status(403).json({
          error: 'Forbidden',
          message: 'You do not have permission to update this project'
        });
      }

      const project = await prisma.project.update({
        where: { id },
        data: updateData,
        include: {
          owner: {
            select: {
              id: true,
              name: true,
              email: true
            }
          }
        }
      });

      res.json({
        message: 'Project updated successfully',
        project
      });
    } catch (error) {
      next(error);
    }
  }
);

/**
 * Delete Project
 * DELETE /api/projects/:id
 */
router.delete(
  '/:id',
  authorize('ADMIN'),
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      const { id } = req.params;

      const project = await prisma.project.findUnique({
        where: { id }
      });

      if (!project) {
        return res.status(404).json({
          error: 'Not Found',
          message: 'Project not found'
        });
      }

      await prisma.project.delete({
        where: { id }
      });

      res.json({
        message: 'Project deleted successfully'
      });
    } catch (error) {
      next(error);
    }
  }
);

export default router;
