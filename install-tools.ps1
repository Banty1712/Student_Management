# Student Management System - Tool Setup Script
# This script installs Maven and configures the environment

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Tool Installation Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')

if (-not $isAdmin) {
    Write-Host "WARNING: This script requires Administrator privileges." -ForegroundColor Yellow
    Read-Host "Close this window and run as Administrator. Press Enter"
    exit 1
}

# Create install directory
$installDir = "C:\tools"
New-Item -ItemType Directory -Path $installDir -Force | Out-Null
Write-Host "Installation directory: $installDir" -ForegroundColor Green

# Install Maven
Write-Host ""
Write-Host "Installing Apache Maven..." -ForegroundColor Yellow

$mavenVersion = "3.9.6"
$mavenUrl = "https://archive.apache.org/dist/maven/maven-3/$mavenVersion/binaries/apache-maven-$mavenVersion-bin.zip"
$mavenZip = "$env:TEMP\apache-maven-$mavenVersion-bin.zip"
$mavenHome = "$installDir\maven"

if (Test-Path $mavenHome) {
    Write-Host "Maven already installed" -ForegroundColor Green
} else {
    try {
        Write-Host "Downloading Maven..." -ForegroundColor Gray
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip -ErrorAction Stop
        
        Write-Host "Extracting Maven..." -ForegroundColor Gray
        Expand-Archive -Path $mavenZip -DestinationPath $installDir -Force
        Rename-Item -Path "$installDir\apache-maven-$mavenVersion" -NewName "maven" -Force
        Remove-Item $mavenZip -Force -ErrorAction SilentlyContinue
        Write-Host "Maven installed successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to install Maven: $_" -ForegroundColor Red
        exit 1
    }
}

# Configure Environment Variables
Write-Host ""
Write-Host "Configuring Environment Variables..." -ForegroundColor Yellow

[Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenHome, "Machine")
$pathVar = [Environment]::GetEnvironmentVariable("Path", "Machine")
if (-not $pathVar.Contains("$mavenHome\bin")) {
    [Environment]::SetEnvironmentVariable("Path", "$pathVar;$mavenHome\bin", "Machine")
}
Write-Host "Environment variables configured" -ForegroundColor Green

# Check MySQL
Write-Host ""
Write-Host "Checking MySQL..." -ForegroundColor Yellow

$mySqlPath = $null
$mySqlPaths = @(
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe"
)

foreach ($path in $mySqlPaths) {
    if (Test-Path $path) {
        $mySqlPath = $path
        break
    }
}

if ($mySqlPath) {
    Write-Host "MySQL found: $mySqlPath" -ForegroundColor Green
}
else {
    Write-Host "MySQL not found. Download from: https://dev.mysql.com/downloads/mysql/" -ForegroundColor Yellow
}

# Final Status
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Maven Home: $mavenHome" -ForegroundColor Cyan
Write-Host "MySQL Status: $(if ($mySqlPath) { 'Installed' } else { 'Not Found' })" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Close this window" -ForegroundColor Gray
Write-Host "2. Open a new PowerShell window" -ForegroundColor Gray
Write-Host "3. Verify: mvn -version" -ForegroundColor Gray
Write-Host "4. Install MySQL if needed" -ForegroundColor Gray
Write-Host "5. Run: cd D:\Student_Management" -ForegroundColor Gray
Write-Host "6. Run: .\build.ps1 -Action build" -ForegroundColor Gray
Write-Host ""
Read-Host "Press Enter to exit"
