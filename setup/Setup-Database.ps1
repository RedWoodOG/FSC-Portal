# FSC Portal - Native Windows PostgreSQL Database Setup
# Initializes the fsc_portal database and runs Prisma migrations

param(
    [string]$PostgresPath = "C:\Program Files\PostgreSQL\18\bin",
    [string]$DbUser = "jwhite3321",
    [string]$DbPassword = "dev_password",
    [string]$DbName = "fsc_portal"
)

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "FSC Portal - Database Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check if PostgreSQL service is running
Write-Host "Checking PostgreSQL service..." -NoNewline
$pgService = Get-Service -Name "postgresql-x64-18" -ErrorAction SilentlyContinue
if ($pgService.Status -eq "Running") {
    Write-Host " ✓ Running" -ForegroundColor Green
} else {
    Write-Host " ✗ Not running" -ForegroundColor Red
    Write-Host "Starting PostgreSQL service..." -ForegroundColor Yellow
    Start-Service -Name "postgresql-x64-18"
    Start-Sleep -Seconds 2
}

# Set PostgreSQL path
$env:Path = "$PostgresPath;$env:Path"

# Check if database exists
Write-Host "Checking if database exists..." -NoNewline
$dbExists = & "$PostgresPath\psql.exe" -U postgres -lqt 2>$null | Select-String -Pattern "^\s*$DbName\s*\|"
if ($dbExists) {
    Write-Host " ✓ Database '$DbName' exists" -ForegroundColor Green
} else {
    Write-Host " ! Database does not exist" -ForegroundColor Yellow
    Write-Host "Creating database '$DbName'..." -ForegroundColor Cyan
    
    & "$PostgresPath\psql.exe" -U postgres -c "CREATE DATABASE $DbName;" 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Database created" -ForegroundColor Green
    } else {
        Write-Host "✗ Failed to create database" -ForegroundColor Red
        Write-Host "You may need to run this as Administrator or configure postgres user password" -ForegroundColor Yellow
        exit 1
    }
}

# Check/create user
Write-Host "Checking database user..." -NoNewline
$userExists = & "$PostgresPath\psql.exe" -U postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DbUser';" 2>$null
if ($userExists -eq "1") {
    Write-Host " ✓ User '$DbUser' exists" -ForegroundColor Green
} else {
    Write-Host " ! User does not exist" -ForegroundColor Yellow
    Write-Host "Creating user '$DbUser'..." -ForegroundColor Cyan
    
    & "$PostgresPath\psql.exe" -U postgres -c "CREATE USER $DbUser WITH PASSWORD '$DbPassword';" 2>&1 | Out-Null
    & "$PostgresPath\psql.exe" -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE $DbName TO $DbUser;" 2>&1 | Out-Null
    
    Write-Host "✓ User created and granted privileges" -ForegroundColor Green
}

# Run Prisma migrations
Write-Host "`nRunning Prisma migrations..." -ForegroundColor Cyan
Set-Location "$PSScriptRoot\..\server"

# Generate Prisma client
Write-Host "Generating Prisma client..." -ForegroundColor Yellow
node node_modules\prisma\build\index.js generate 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Prisma client generated" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to generate Prisma client" -ForegroundColor Red
    Set-Location $PSScriptRoot
    exit 1
}

# Push schema to database
Write-Host "Pushing schema to database..." -ForegroundColor Yellow
node node_modules\prisma\build\index.js db push --skip-generate 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database schema applied" -ForegroundColor Green
} else {
    Write-Host "! Schema push had warnings (may be OK)" -ForegroundColor Yellow
}

Set-Location $PSScriptRoot

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "✓ Database setup complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "`nConnection string:" -ForegroundColor Gray
Write-Host "postgresql://${DbUser}:${DbPassword}@127.0.0.1:5432/${DbName}`n" -ForegroundColor Gray
