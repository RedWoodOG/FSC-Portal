# FSC Portal - Development Server Startup
# Starts native Windows PostgreSQL service and backend server

param(
    [switch]$SkipDatabase
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "FSC Portal - Starting Development Environment" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check PostgreSQL Service
if (-not $SkipDatabase) {
    Write-Host "Checking PostgreSQL service..." -ForegroundColor Yellow
    
    $pgService = Get-Service -Name "postgresql-x64-18" -ErrorAction SilentlyContinue
    
    if (-not $pgService) {
        Write-Host "✗ PostgreSQL service not found" -ForegroundColor Red
        Write-Host "  Please install PostgreSQL 18 for Windows" -ForegroundColor Yellow
        exit 1
    }
    
    if ($pgService.Status -ne "Running") {
        Write-Host "Starting PostgreSQL service..." -ForegroundColor Cyan
        Start-Service -Name "postgresql-x64-18"
        Start-Sleep -Seconds 2
        Write-Host "✓ PostgreSQL started" -ForegroundColor Green
    } else {
        Write-Host "✓ PostgreSQL already running" -ForegroundColor Green
    }
    
    # Test connection
    Write-Host "Testing database connection..." -NoNewline
    $connTest = Test-NetConnection -ComputerName 127.0.0.1 -Port 5432 -InformationLevel Quiet -WarningAction SilentlyContinue
    if ($connTest) {
        Write-Host " ✓ Connected" -ForegroundColor Green
    } else {
        Write-Host " ✗ Failed" -ForegroundColor Red
        exit 1
    }
}

# Start Backend Server
Write-Host "`nStarting FSC Portal backend server..." -ForegroundColor Yellow

try {
    Set-Location server
    
    Write-Host "Launching Node.js server with TypeScript..." -ForegroundColor Cyan
    
    # Run server with tsx (TypeScript executor)
    node node_modules\tsx\dist\cli.mjs src\index.ts
    
} catch {
    Write-Host "✗ Error starting server: $_" -ForegroundColor Red
    Set-Location ..
    exit 1
} finally {
    Set-Location ..
}
