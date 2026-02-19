@REM Build script for Student Management System

@echo off
setlocal enabledelayedexpansion

echo ============================================
echo Student Management System - Web Build
echo ============================================
echo.

REM Check if Maven is installed
where mvn >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Maven is not installed or not in PATH
    echo Please install Maven from https://maven.apache.org/
    echo.
    pause
    exit /b 1
)

REM Check if Java is installed
where java >nul 2>nul
if %errorlevel% neq 0 (
    echo Error: Java is not installed or not in PATH
    echo Please install JDK 11 or higher
    echo.
    pause
    exit /b 1
)

echo Detected Maven and Java
java -version
echo.

REM Parse arguments
set ACTION=%1
if "%ACTION%"=="" set ACTION=help

REM Clean
if "%ACTION%"=="clean" (
    echo Cleaning project...
    call mvn clean
    if %errorlevel% equ 0 (
        echo Successfully cleaned project
    ) else (
        echo Error during clean
        pause
        exit /b 1
    )
    goto end
)

REM Build
if "%ACTION%"=="build" (
    echo Building web application...
    call mvn clean package
    if %errorlevel% equ 0 (
        echo.
        echo Build successful!
        echo WAR file created at: target\student-management.war
    ) else (
        echo Build failed
        pause
        exit /b 1
    )
    goto end
)

REM Compile only
if "%ACTION%"=="compile" (
    echo Compiling project...
    call mvn clean compile
    if %errorlevel% equ 0 (
        echo Compilation successful!
    ) else (
        echo Compilation failed
        pause
        exit /b 1
    )
    goto end
)

REM Deploy with Maven-Tomcat plugin
if "%ACTION%"=="deploy" (
    echo Deploying to Tomcat...
    call mvn tomcat7:deploy
    goto end
)

REM Show help
echo Usage: build.bat [ACTION]
echo.
echo Actions:
echo   clean       - Clean build artifacts
echo   compile     - Compile source code only
echo   build       - Build WAR package (Clean + Compile + Package)
echo   deploy      - Deploy to Tomcat using Maven plugin
echo   help        - Show this help message
echo.
echo Example:
echo   build.bat build
echo   build.bat clean
echo.

:end
echo.
pause
