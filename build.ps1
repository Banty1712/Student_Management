#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('clean', 'compile', 'build', 'deploy', 'help')]
    [string]$Action = 'help'
)

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Student Management System - Web Build" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if Maven is installed
$mavenCheck = & where.exe mvn 2>$null
if (-not $mavenCheck) {
    Write-Host "Error: Maven is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install Maven from https://maven.apache.org/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if Java is installed
$javaCheck = & where.exe java 2>$null
if (-not $javaCheck) {
    Write-Host "Error: Java is not installed or not in PATH" -ForegroundColor Red
    Write-Host "Please install JDK 11 or higher" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Detected Maven and Java" -ForegroundColor Green
& java -version
Write-Host ""

switch ($Action) {
    'clean' {
        Write-Host "Cleaning project..." -ForegroundColor Yellow
        & mvn clean
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Successfully cleaned project" -ForegroundColor Green
        } else {
            Write-Host "Error during clean" -ForegroundColor Red
            exit 1
        }
    }
    
    'compile' {
        Write-Host "Compiling project..." -ForegroundColor Yellow
        & mvn clean compile
        if ($LASTEXITCODE -eq 0) {
            Write-Host "Compilation successful!" -ForegroundColor Green
        } else {
            Write-Host "Compilation failed" -ForegroundColor Red
            exit 1
        }
    }
    
    'build' {
        Write-Host "Building web application..." -ForegroundColor Yellow
        & mvn clean package
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "Build successful!" -ForegroundColor Green
            Write-Host "WAR file created at: target\student-management.war" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Next steps:" -ForegroundColor Yellow
            Write-Host "1. Install Apache Tomcat 9.0 or higher" -ForegroundColor Gray
            Write-Host "2. Copy 'target\student-management.war' to 'TOMCAT_HOME\webapps\'" -ForegroundColor Gray
            Write-Host "3. Start Tomcat server" -ForegroundColor Gray
            Write-Host "4. Visit http://localhost:8080/student-management/" -ForegroundColor Gray
        } else {
            Write-Host "Build failed" -ForegroundColor Red
            exit 1
        }
    }
    
    'deploy' {
        Write-Host "Deploying to Tomcat..." -ForegroundColor Yellow
        & mvn tomcat7:deploy
    }
    
    'help' {
        Write-Host "Usage: .\build.ps1 -Action [ACTION]" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Actions:" -ForegroundColor Yellow
        Write-Host "  clean       - Clean build artifacts" -ForegroundColor Gray
        Write-Host "  compile     - Compile source code only" -ForegroundColor Gray
        Write-Host "  build       - Build WAR package (Clean + Compile + Package)" -ForegroundColor Gray
        Write-Host "  deploy      - Deploy to Tomcat using Maven plugin" -ForegroundColor Gray
        Write-Host "  help        - Show this help message" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Examples:" -ForegroundColor Yellow
        Write-Host "  .\build.ps1 -Action build" -ForegroundColor Cyan
        Write-Host "  .\build.ps1 -Action clean" -ForegroundColor Cyan
        Write-Host "  .\build.ps1" -ForegroundColor Cyan
        Write-Host ""
    }
}

Write-Host ""
