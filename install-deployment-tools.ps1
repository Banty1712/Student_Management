# Installation script for MySQL Server and Apache Tomcat
# Run as Administrator

Write-Host "================================" -ForegroundColor Green
Write-Host "Student Management Deployment Setup" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green

$TomcatVersion = "11.0.2"
$TomcatDownloadUrl = "https://archive.apache.org/dist/tomcat/tomcat-11/v${TomcatVersion}/bin/apache-tomcat-${TomcatVersion}.zip"
$InstallDir = "C:\tools"
$ProjectDir = "D:\Student_Management"

# Step 1: Create tools directory if it doesn't exist
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    Write-Host "Created $InstallDir directory" -ForegroundColor Green
}

# Step 2: Download and extract Tomcat
Write-Host "`n[1/3] Installing Apache Tomcat..." -ForegroundColor Yellow

$TomcatZip = "$InstallDir\apache-tomcat-${TomcatVersion}.zip"
$TomcatHome = "$InstallDir\tomcat"

if (Test-Path $TomcatHome) {
    Write-Host "Tomcat already installed at $TomcatHome" -ForegroundColor Green
} else {
    try {
        Write-Host "Downloading Tomcat ${TomcatVersion}..." -ForegroundColor Cyan
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocol]::Tls12
        Invoke-WebRequest -Uri $TomcatDownloadUrl -OutFile $TomcatZip -UseBasicParsing
        
        Write-Host "Extracting Tomcat..." -ForegroundColor Cyan
        Expand-Archive -Path $TomcatZip -DestinationPath $InstallDir -Force
        
        # Rename to simpler name
        $ExtractedFolder = "$InstallDir\apache-tomcat-${TomcatVersion}"
        if (Test-Path $ExtractedFolder) {
            Rename-Item -Path $ExtractedFolder -NewName "tomcat" -Force
        }
        
        # Set environment variable
        [Environment]::SetEnvironmentVariable("CATALINA_HOME", $TomcatHome, "User")
        
        Write-Host "Tomcat installed successfully at $TomcatHome" -ForegroundColor Green
    } catch {
        Write-Host "Error downloading Tomcat: $_" -ForegroundColor Red
        Write-Host "Please download manually from: https://tomcat.apache.org/download-11.cgi" -ForegroundColor Yellow
    }
}

# Step 3: Download and install MySQL Community Server
Write-Host "`n[2/3] Installing MySQL..." -ForegroundColor Yellow

$MySqlInstallerUrl = "https://cdn.mysql.com//Downloads/MySQLInstaller/mysql-installer-community-8.0.43.0.msi"
$MySqlInstaller = "C:\tools\mysql-installer.msi"

try {
    Write-Host "Downloading MySQL Community Server 8.0..." -ForegroundColor Cyan
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocol]::Tls12
    Invoke-WebRequest -Uri $MySqlInstallerUrl -OutFile $MySqlInstaller -UseBasicParsing
    
    Write-Host "MySQL installer downloaded to: $MySqlInstaller" -ForegroundColor Green
    Write-Host "Starting MySQL installer..." -ForegroundColor Cyan
    
    # Run MySQL installer
    Start-Process -FilePath $MySqlInstaller -Wait -NoNewWindow
    
    Write-Host "MySQL installation completed. Please configure during installer wizard." -ForegroundColor Green
    Write-Host "Recommended MySQL settings:" -ForegroundColor Yellow
    Write-Host "  - Port: 3306" -ForegroundColor White
    Write-Host "  - Root password: root123 (or your preference)" -ForegroundColor White
    Write-Host "  - Service name: MySQL80" -ForegroundColor White
    
} catch {
    Write-Host "Error downloading MySQL: $_" -ForegroundColor Red
    Write-Host "You can download MySQL manually from: https://dev.mysql.com/downloads/mysql/" -ForegroundColor Yellow
}

# Step 4: Configure Tomcat context for database
Write-Host "`n[3/3] Configuring Tomcat for Student Management App..." -ForegroundColor Yellow

$ContextXmlPath = "$TomcatHome\conf\Catalina\localhost\student-management.xml"
$ContextXmlDir = Split-Path -Path $ContextXmlPath

if (-not (Test-Path $ContextXmlDir)) {
    New-Item -ItemType Directory -Path $ContextXmlDir -Force | Out-Null
}

# Create context configuration file
$ContextXmlContent = @'
<?xml version="1.0" encoding="UTF-8"?>
<Context docBase="D:\Student_Management\target\student-management.war" 
         path="/student-management" 
         reloadable="true">
</Context>
'@

$ContextXmlContent | Out-File -FilePath $ContextXmlPath -Encoding UTF8 -Force
Write-Host "Tomcat context configured" -ForegroundColor Green

# Step 5: Display next steps
Write-Host "`n" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "INSTALLATION SUMMARY" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nAfter installation completes, follow these steps:" -ForegroundColor Yellow
Write-Host "`n1. Initialize Database:" -ForegroundColor Cyan
Write-Host "   mysql -u root -p < D:\Student_Management\database-setup.sql" -ForegroundColor White
Write-Host "   (Enter your MySQL root password when prompted)" -ForegroundColor Gray

Write-Host "`n2. Deploy Application:" -ForegroundColor Cyan
Write-Host "   Copy: D:\Student_Management\target\student-management.war" -ForegroundColor White
Write-Host "   To:   $TomcatHome\webapps\" -ForegroundColor White

Write-Host "`n3. Start Tomcat:" -ForegroundColor Cyan
Write-Host "   $TomcatHome\bin\startup.bat" -ForegroundColor White

Write-Host "`n4. Access Application:" -ForegroundColor Cyan
Write-Host "   http://localhost:8080/student-management/" -ForegroundColor White

Write-Host "`n5. Stop Tomcat:" -ForegroundColor Cyan
Write-Host "   $TomcatHome\bin\shutdown.bat" -ForegroundColor White

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Installation complete! `n" -ForegroundColor Green
