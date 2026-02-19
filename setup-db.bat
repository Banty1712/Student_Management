@echo off
REM Database Setup Script for Student Management System
REM This runs the SQL setup script on MySQL

echo ============================================
echo Student Management Database Setup
echo ============================================
echo.

REM Get MySQL path
set MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe

REM Verify MySQL exists
if not exist "%MYSQL_PATH%" (
    echo Error: MySQL not found at %MYSQL_PATH%
    echo Please install MySQL Community Server from:
    echo https://dev.mysql.com/downloads/mysql/
    pause
    exit /b 1
)

echo [OK] MySQL found at: %MYSQL_PATH%
echo.
echo This will create the student_mgmt database with tables and sample data.
echo.

REM Run the SQL setup script
cd /d D:\Student_Management
"%MYSQL_PATH%" -u root -p < database-setup.sql

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Database setup failed!
    echo Make sure:
    echo  1. MySQL Server is running
    echo  2. Root password is correct
    echo  3. File D:\Student_Management\database-setup.sql exists
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo [SUCCESS] Database initialized!
echo ============================================
echo.
echo Verifying database...
"%MYSQL_PATH%" -u root -p -e "USE student_mgmt; SELECT COUNT(*) as total_students FROM student; SELECT COUNT(*) as total_branches FROM branch;"

echo.
echo Database setup complete!
echo Your web application is now ready to use.
echo Visit: http://localhost:8080/student-management/
echo.
pause
