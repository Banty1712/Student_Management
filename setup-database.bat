@echo off
REM Database Setup Script for Student Management System
REM This script creates the database and tables using the SQL dump file

setlocal enabledelayedexpansion

echo ============================================
echo Student Management Database Setup
echo ============================================
echo.

REM Check if MySQL is installed
mysql --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] MySQL is not installed or not in PATH
    echo.
    echo Please install MySQL Community Server from:
    echo https://dev.mysql.com/downloads/mysql/
    echo.
    pause
    exit /b 1
)

echo [OK] MySQL found
echo.
echo Database setup will create/configure:
echo   - Database: student_mgmt
echo   - Tables: branch, student
echo   - Sample data: 5 branches, 10 students
echo.

set /p mysqlPass="Enter MySQL root password: "

echo.
echo Initializing database...
mysql -u root -p%mysqlPass% < D:\Student_Management\database-setup.sql

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Database setup failed!
    echo Check your MySQL password and try again.
    echo.
    pause
    exit /b 1
)

echo.
echo ============================================
echo [SUCCESS] Database initialized!
echo ============================================
echo.
echo Verifying database setup...
mysql -u root -p%mysqlPass% -e "USE student_mgmt; SHOW TABLES; SELECT 'Branches:' AS ''; SELECT COUNT(*) FROM branch; SELECT 'Students:' AS ''; SELECT COUNT(*) FROM student;"

echo.
echo Next steps:
echo 1. Start Tomcat: D:\Student_Management\start-tomcat.bat
echo 2. Access application: http://localhost:8080/student-management/
echo.
pause
