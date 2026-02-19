@echo off
REM Fix MySQL root user authentication plugin from caching_sha2_password to mysql_native_password
REM This is required for JDBC MySQL Connector/J 8.0 to authenticate successfully

echo ========================================
echo Fixing MySQL Authentication
echo ========================================
echo.

echo Step 1: Testing current MySQL connection status...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "SELECT 'Connected' as status;" 2>&1
if %ERRORLEVEL% equ 0 (
    echo SUCCESS: MySQL is accessible with root/admin
) else (
    echo WARNING: Initial connection test failed, but continuing with fix...
)

echo.
echo Step 2: Converting root user to mysql_native_password...
REM Using a temporary SQL file to avoid command-line escaping issues
(
echo ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';
echo FLUSH PRIVILEGES;
echo SELECT USER, plugin FROM mysql.user WHERE user='root';
) | "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin

echo.
echo Step 3: Verifying authentication change...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "SHOW VARIABLES LIKE 'default_authentication_plugin';" 2>&1

echo.
echo Step 4: Verifying database and data...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "SELECT COUNT(*) as branch_count FROM student_management.branch; SELECT user, plugin FROM mysql.user WHERE user='root';" 2>&1

echo.
echo ========================================
echo MySQL Authentication Fix Complete
echo ========================================
pause
