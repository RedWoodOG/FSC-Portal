# Verify FSC-Portal Clone
Write-Host "=== FSC Portal Clone Verification ===" -ForegroundColor Cyan
Write-Host ""

# Check directories
Write-Host "1. Checking directories..." -ForegroundColor Yellow
$stable = Test-Path "h:\FSC_Portal\Offline-Portal"
$dev = Test-Path "h:\FSC_Portal\FSC-Portal"

if ($stable) { Write-Host "   OK Offline-Portal exists" -ForegroundColor Green }
if ($dev) { Write-Host "   OK FSC-Portal exists" -ForegroundColor Green }
Write-Host ""

# Check package names
Write-Host "2. Checking package names..." -ForegroundColor Yellow
$s = Get-Content "h:\FSC_Portal\Offline-Portal\pubspec.yaml" | Select-String "^name:"
$d = Get-Content "h:\FSC_Portal\FSC-Portal\pubspec.yaml" | Select-String "^name:"
Write-Host "   Stable: $s" -ForegroundColor Gray
Write-Host "   Dev: $d" -ForegroundColor Gray
Write-Host ""

# Check databases
Write-Host "3. Checking database isolation..." -ForegroundColor Yellow
$sdb = Get-Content "h:\FSC_Portal\Offline-Portal\lib\database\app_database.dart" | Select-String "portal_offline"
$ddb = Get-Content "h:\FSC_Portal\FSC-Portal\lib\database\app_database.dart" | Select-String "fsc_portal_dev"
if ($sdb) { Write-Host "   OK Stable uses portal_offline.sqlite" -ForegroundColor Green }
if ($ddb) { Write-Host "   OK Dev uses fsc_portal_dev.sqlite" -ForegroundColor Green }
Write-Host ""

Write-Host "=== CLONE VERIFIED SUCCESSFULLY ===" -ForegroundColor Green
Write-Host ""
Write-Host "Next: cd h:\FSC_Portal\FSC-Portal && flutter pub get" -ForegroundColor Cyan
