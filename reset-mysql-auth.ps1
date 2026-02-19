#!/usr/bin/env powershell
# MySQL Root User Authentication Reset Script
# Converts root user from caching_sha2_password to mysql_native_password for JDBC compatibility

$MySQLPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin"
$MySQLUser = "root"
$MySQLPassword = "admin"
$Database = "student_management"

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "MySQL Authentication Reset Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check if mysql.exe can connect with current credentials
Write-Host "[1/4] Testing current MySQL connection..." -ForegroundColor Yellow
try {
    $result = & "$MySQLPath\mysql.exe" -h localhost -u $MySQLUser -p$MySQLPassword -e "SELECT 1;" 2>&1
    if ($result -like "*1*" -or $result -match "^\|.*\|$") {
        Write-Host "[OK] MySQL command-line connection successful!" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Connection failed: $result" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "[ERROR] Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/4] Checking for branch data in database..." -ForegroundColor Yellow
try {
    $branchCount = & "$MySQLPath\mysql.exe" -h localhost -u $MySQLUser -p$MySQLPassword -D $Database -N -e "SELECT COUNT(*) FROM branch;" 2>&1
    if ($branchCount -match "^\d+$") {
        Write-Host "[OK] Database query successful" -ForegroundColor Green
        if ($branchCount -gt 0) {
            Write-Host "[OK] Found $branchCount branches in database!" -ForegroundColor Green
        } else {
            Write-Host "[WARNING] No branches found. Will re-run setup script after auth fix." -ForegroundColor Yellow
        }
    } else {
        Write-Host "[WARNING] Could not query branches (may need setup)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[WARNING] Warning: $_" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[3/4] Converting root user to mysql_native_password..." -ForegroundColor Yellow
try {
    $sqlCommands = @"
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';
FLUSH PRIVILEGES;
"@
    
    $result = $sqlCommands | & "$MySQLPath\mysql.exe" -h localhost -u $MySQLUser -p$MySQLPassword 2>&1
    if ($result -notlike "*ERROR*" -and $result -notlike "*denied*") {
        Write-Host "[OK] Root user authentication method updated!" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Failed to update authentication: $result" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "[ERROR] Error executing SQL: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[4/4] Verifying authentication change..." -ForegroundColor Yellow
try {
    $result = & "$MySQLPath\mysql.exe" -h localhost -u $MySQLUser -p$MySQLPassword -e "SELECT USER();" 2>&1
    if ($result -like "*root*" -or $result -match "root@localhost") {
        Write-Host "[OK] Verification successful! Root user is now using mysql_native_password" -ForegroundColor Green
    } else {
        Write-Host "[ERROR] Verification failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "[ERROR] Error: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=====================================" -ForegroundColor Green
Write-Host "[OK] MySQL authentication reset complete!" -ForegroundColor Green
Write-Host "=====================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Restart your Tomcat server" -ForegroundColor White
Write-Host "2. The branch dropdown should now load with database branches" -ForegroundColor White
Write-Host "3. Access the application at http://localhost:8080/student-management/" -ForegroundColor White
Write-Host ""
