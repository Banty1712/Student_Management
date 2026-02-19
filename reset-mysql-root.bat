@echo off
REM Reset MySQL root user authentication
REM This script resets the root password by starting MySQL without grant tables

echo ========================================
echo MySQL Root Password Reset Procedure
echo ========================================
echo.

REM Step 1: Stop MySQL service
echo Step 1: Stopping MySQL80 service...
net stop MySQL80 2>&1 | findstr /E "stopped|already"
if %ERRORLEVEL% neq 0 (
    taskkill /F /IM mysqld.exe 2>&1 | findstr /E "SUCCESS|No tasks"
)
timeout /t 3 /nobreak

REM Step 2: Start MySQL without grant tables (bypass authentication)
echo.
echo Step 2: Starting MySQL without grant tables...
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
start "MySQL Skip Grant tables" mysqld --skip-grant-tables --skip-networking
timeout /t 3 /nobreak

REM Step 3: Reset root authentication using mysql.exe with no authentication
echo.
echo Step 3: Resetting root user authentication...
(
echo FLUSH PRIVILEGES;
echo ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';
echo FLUSH PRIVILEGES;
echo SELECT USER, HOST, plugin FROM mysql.user WHERE USER='root';
) | "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root --skip-password 2>&1

echo.
echo Step 4: Stopping MySQL (skip-grant-tables instance)...
taskkill /F /IM mysqld.exe 2>&1 | findstr /E "SUCCESS|No tasks"
timeout /t 3 /nobreak

REM Step 5: Start MySQL service normally
echo.
echo Step 5: Starting MySQL80 service normally...
net start MySQL80 2>&1 | findstr /E "started|already"
timeout /t 3 /nobreak

REM Step 6: Verify the change
echo.
echo Step 6: Verifying authentication change...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "SELECT USER, HOST, plugin FROM mysql.user WHERE USER='root'; SELECT 'SUCCESS: Root authentication fixed!' as result;" 2>&1

echo.
echo ========================================
echo MySQL authentication reset complete!
echo You can now close this window.
echo ========================================
pause
