import { Request, Response, NextFunction } from 'express';
import { Prisma } from '@prisma/client';

export interface AppError extends Error {
  statusCode?: number;
  code?: string;
}

/**
 * Global Error Handler Middleware
 * Handles all errors and returns appropriate responses
 */
export const errorHandler = (
  err: AppError | Error,
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  // Log error
  console.error('Error:', {
    message: err.message,
    stack: process.env.NODE_ENV === 'development' ? err.stack : undefined,
    path: req.path,
    method: req.method
  });

  // Prisma errors
  if (err instanceof Prisma.PrismaClientKnownRequestError) {
    handlePrismaError(err, res);
    return;
  }

  if (err instanceof Prisma.PrismaClientValidationError) {
    res.status(400).json({
      error: 'Validation Error',
      message: 'Invalid database query'
    });
    return;
  }

  // Custom application errors
  const statusCode = (err as AppError).statusCode || 500;
  const message = err.message || 'Internal Server Error';

  res.status(statusCode).json({
    error: statusCode >= 500 ? 'Internal Server Error' : 'Error',
    message: message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
};

/**
 * Handle Prisma-specific errors
 */
function handlePrismaError(
  err: Prisma.PrismaClientKnownRequestError,
  res: Response
): void {
  switch (err.code) {
    case 'P2002':
      res.status(409).json({
        error: 'Conflict',
        message: 'A record with this value already exists'
      });
      break;
    case 'P2025':
      res.status(404).json({
        error: 'Not Found',
        message: 'Record not found'
      });
      break;
    case 'P2003':
      res.status(400).json({
        error: 'Bad Request',
        message: 'Foreign key constraint failed'
      });
      break;
    default:
      res.status(500).json({
        error: 'Database Error',
        message: 'An error occurred while processing your request'
      });
  }
}

/**
 * Create custom error
 */
export const createError = (message: string, statusCode: number = 500): AppError => {
  const error = new Error(message) as AppError;
  error.statusCode = statusCode;
  return error;
};
