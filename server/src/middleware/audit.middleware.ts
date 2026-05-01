import { Request, Response, NextFunction } from 'express';
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

/**
 * Audit Logging Middleware
 * Logs all API requests for security and compliance
 */
export const auditLogger = async (
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> => {
  // Skip logging for health checks and static assets
  if (req.path === '/health' || req.path.startsWith('/static')) {
    next();
    return;
  }

  const startTime = Date.now();

  // Capture response
  const originalSend = res.send;
  res.send = function (body) {
    const duration = Date.now() - startTime;

    // Log asynchronously (don't block response)
    logAuditEntry(req, res, duration).catch(console.error);

    return originalSend.call(this, body);
  };

  next();
};

/**
 * Log audit entry to database
 */
async function logAuditEntry(
  req: Request,
  res: Response,
  duration: number
): Promise<void> {
  try {
    const userId = req.user?.id || null;
    const action = `${req.method} ${req.path}`;
    const resourceType = extractResourceType(req.path);
    const resourceId = extractResourceId(req.path);

    await prisma.auditLog.create({
      data: {
        userId,
        action,
        resourceType,
        resourceId,
        ipAddress: req.ip || req.socket.remoteAddress || undefined,
        userAgent: req.get('user-agent') || undefined,
        changes: req.method !== 'GET' ? {
          body: sanitizeBody(req.body),
          query: req.query
        } : undefined
      }
    });
  } catch (error) {
    // Don't fail request if audit logging fails
    console.error('Audit logging error:', error);
  }
}

/**
 * Extract resource type from path
 */
function extractResourceType(path: string): string | null {
  const match = path.match(/\/api\/(\w+)/);
  return match ? match[1] : null;
}

/**
 * Extract resource ID from path
 */
function extractResourceId(path: string): string | null {
  const match = path.match(/\/api\/\w+\/([a-f0-9-]{36})/);
  return match ? match[1] : null;
}

/**
 * Sanitize request body for logging (remove sensitive data)
 */
function sanitizeBody(body: any): any {
  if (!body || typeof body !== 'object') {
    return body;
  }

  const sensitiveFields = ['password', 'passwordHash', 'token', 'secret', 'key'];
  const sanitized = { ...body };

  for (const field of sensitiveFields) {
    if (sanitized[field]) {
      sanitized[field] = '[REDACTED]';
    }
  }

  return sanitized;
}
