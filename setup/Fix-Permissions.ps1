# FSC Portal - Fix PostgreSQL Permissions
# Grants full permissions to your user on your database

param(
    [string]$PostgresPath = "C:\Program Files\PostgreSQL\18\bin",
    [string]$DbUser = "jwhite3321",
    [string]$DbName = "fsc_portal"
)

Write-Host "`nFixing PostgreSQL permissions for $DbUser on $DbName..." -ForegroundColor Cyan

$env:Path = "$PostgresPath;$env:Path"

# Grant all privileges on database
Write-Host "Granting database privileges..." -NoNewline
& "$PostgresPath\psql.exe" -U postgres -d $DbName -c "GRANT ALL PRIVILEGES ON DATABASE $DbName TO $DbUser;" 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

# Grant schema privileges
Write-Host "Granting schema privileges..." -NoNewline
& "$PostgresPath\psql.exe" -U postgres -d $DbName -c "GRANT ALL ON SCHEMA public TO $DbUser;" 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

# Grant create privileges
Write-Host "Granting CREATE privileges..." -NoNewline
& "$PostgresPath\psql.exe" -U postgres -d $DbName -c "GRANT CREATE ON SCHEMA public TO $DbUser;" 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

# Grant usage privileges
Write-Host "Granting USAGE privileges..." -NoNewline
& "$PostgresPath\psql.exe" -U postgres -d $DbName -c "GRANT USAGE ON SCHEMA public TO $DbUser;" 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

# Make user owner of the database
Write-Host "Making $DbUser owner of database..." -NoNewline
& "$PostgresPath\psql.exe" -U postgres -c "ALTER DATABASE $DbName OWNER TO $DbUser;" 2>&1 | Out-Null
Write-Host " ✓" -ForegroundColor Green

Write-Host "`n✓ Permissions fixed! $DbUser now has full control of $DbName`n" -ForegroundColor Green
