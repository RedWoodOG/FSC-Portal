# FSC Portal - System Verification Script
# Checks all prerequisites and current state

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "FSC Portal System Verification" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$allGood = $true

# Check Node.js
Write-Host "Checking Node.js..." -NoNewline
try {
    $nodeVersion = node --version 2>$null
    if ($nodeVersion) {
        Write-Host " ✓ $nodeVersion" -ForegroundColor Green
    } else {
        Write-Host " ✗ Not found" -ForegroundColor Red
        $allGood = $false
    }
} catch {
    Write-Host " ✗ Not found" -ForegroundColor Red
    $allGood = $false
}

# Check npm
Write-Host "Checking npm..." -NoNewline
try {
    $npmVersion = npm --version 2>$null
    if ($npmVersion) {
        Write-Host " ✓ $npmVersion" -ForegroundColor Green
    } else {
        Write-Host " ✗ Not found" -ForegroundColor Red
        $allGood = $false
    }
} catch {
    Write-Host " ✗ Not found" -ForegroundColor Red
    $allGood = $false
}

# Check server dependencies
Write-Host "Checking server dependencies..." -NoNewline
if (Test-Path ".\server\node_modules") {
    Write-Host " ✓ Installed" -ForegroundColor Green
} else {
    Write-Host " ✗ Missing (run: cd server; npm install)" -ForegroundColor Red
    $allGood = $false
}

# Check Prisma client
Write-Host "Checking Prisma client..." -NoNewline
if (Test-Path ".\server\node_modules\.prisma") {
    Write-Host " ✓ Generated" -ForegroundColor Green
} else {
    Write-Host " ✗ Not generated (run: cd server; node node_modules\prisma\build\index.js generate)" -ForegroundColor Yellow
    $allGood = $false
}

# Check TypeScript files
Write-Host "Checking TypeScript source..." -NoNewline
$tsFiles = @(
    ".\server\src\index.ts",
    ".\server\src\routes\health.routes.ts",
    ".\server\src\middleware\error.middleware.ts"
)
$missingFiles = @()
foreach ($file in $tsFiles) {
    if (-not (Test-Path $file)) {
        $missingFiles += $file
    }
}
if ($missingFiles.Count -eq 0) {
    Write-Host " ✓ All core files present" -ForegroundColor Green
} else {
    Write-Host " ✗ Missing files: $($missingFiles -join ', ')" -ForegroundColor Red
    $allGood = $false
}

# Check .env file
Write-Host "Checking environment config..." -NoNewline
if (Test-Path ".\server\.env") {
    Write-Host " ✓ .env file exists" -ForegroundColor Green
} else {
    Write-Host " ! .env file missing (will use defaults)" -ForegroundColor Yellow
}

# Check PostgreSQL Windows Service
Write-Host "Checking PostgreSQL service..." -NoNewline
$pgService = Get-Service -Name "postgresql-x64-18" -ErrorAction SilentlyContinue
if ($pgService) {
    if ($pgService.Status -eq "Running") {
        Write-Host " ✓ Running" -ForegroundColor Green
    } else {
        Write-Host " ! Stopped" -ForegroundColor Yellow
        Write-Host "   Run: Start-Service postgresql-x64-18" -ForegroundColor Gray
    }
} else {
    Write-Host " ✗ Not installed" -ForegroundColor Red
    Write-Host "   Install PostgreSQL 18 for Windows" -ForegroundColor Gray
    $allGood = $false
}

# Check PostgreSQL connection
Write-Host "Checking database connection..." -NoNewline
$dbUrl = (Get-Content ".\server\.env" -ErrorAction SilentlyContinue | Select-String "DATABASE_URL").ToString().Split("=")[1]
if ($dbUrl) {
    Write-Host " ? Connection string found (need to test)" -ForegroundColor Yellow
    Write-Host "   URL: $($dbUrl.Substring(0, [Math]::Min(50, $dbUrl.Length)))..." -ForegroundColor Gray
} else {
    Write-Host " ✗ No DATABASE_URL in .env" -ForegroundColor Red
    $allGood = $false
}

# Summary
Write-Host "`n========================================" -ForegroundColor Cyan
if ($allGood) {
    Write-Host "System Status: READY ✓" -ForegroundColor Green
    Write-Host "`nNext steps:" -ForegroundColor Cyan
    Write-Host "1. Ensure database is running (Docker or PostgreSQL service)"
    Write-Host "2. Run: cd server; node node_modules\tsx\dist\cli.mjs src\index.ts"
    Write-Host "3. Test: curl http://localhost:3001/health"
} else {
    Write-Host "System Status: NEEDS ATTENTION" -ForegroundColor Yellow
    Write-Host "`nResolve issues above before proceeding." -ForegroundColor Yellow
}
Write-Host "========================================`n" -ForegroundColor Cyan
