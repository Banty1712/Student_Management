# Student Management System - Deployment Instructions

## Complete Step-by-Step Deployment Guide

### Prerequisites Checklist
- [ ] JDK 11+ installed and configured
- [ ] Maven 3.6+ installed and configured
- [ ] Apache Tomcat 9.0+ downloaded and extracted
- [ ] MySQL 5.7+ installed and running
- [ ] Project source code downloaded/cloned

### Phase 1: Environment Setup

#### Step 1.1: Verify Java Installation
```powershell
java -version
javac -version
```

Expected Output:
```
java version "11.0.x" or higher
javac version "11.0.x" or higher
```

#### Step 1.2: Verify Maven Installation
```powershell
mvn -version
```

Expected Output:
```
Apache Maven x.x.x
...
Java version: 11.0.x
```

#### Step 1.3: Verify MySQL is Running
```powershell
# Windows
Get-Service | Where-Object {$_.Name -like "*MySQL*"}

# Or try to connect
mysql -u root -p
```

### Phase 2: Database Configuration

#### Step 2.1: Create Database and Tables

**Option A: Using MySQL Command Line**
```powershell
cd D:\Student_Management
mysql -u root -p < database-setup.sql
```

**Option B: Using MySQL Workbench**
1. Open MySQL Workbench
2. Connect to your MySQL server
3. Go to File → Open SQL Script
4. Select `database-setup.sql`
5. Click Execute (Lightning bolt icon)
6. Verify tables are created

**Option C: Using MySQL Command**
```powershell
mysql -u root -p<password> < database-setup.sql
```

#### Step 2.2: Verify Database Setup
```sql
-- Connect to MySQL
mysql -u root -p

-- Run these commands
USE student_management;
SHOW TABLES;
SELECT COUNT(*) FROM student;
SELECT COUNT(*) FROM branch;
```

Expected Output:
```
Tables_in_student_management
branch
student

COUNT(*) 
10        (students)

COUNT(*) 
6         (branches)
```

### Phase 3: Configure Database Connection

#### Step 3.1: Update Database Credentials

Edit `src/database/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/student_management";
private static final String USER = "root";           // Replace with your MySQL username
private static final String PASSWORD = "root";       // Replace with your MySQL password
```

**Common Database URLs:**
```java
// Local MySQL (default port)
String URL = "jdbc:mysql://localhost:3306/student_management";

// Remote MySQL
String URL = "jdbc:mysql://192.168.1.100:3306/student_management";

// With SSL
String URL = "jdbc:mysql://localhost:3306/student_management?useSSL=true";
```

#### Step 3.2: Test Database Connection (Optional)

Create a test class or run:
```powershell
mvn clean compile
```

### Phase 4: Build the Application

#### Step 4.1: Build WAR Package

```powershell
cd D:\Student_Management

# Build using PowerShell script
.\build.ps1 -Action build

# OR build using Maven directly
mvn clean package
```

Expected Output:
```
BUILD SUCCESS
Total time: XX.XXXs

WAR file created at: target/student-management.war
```

#### Step 4.2: Verify WAR File Creation

```powershell
ls target/student-management.war
```

Should show the WAR file with size > 5MB

### Phase 5: Tomcat Configuration

#### Step 5.1: Locate Tomcat Installation

**Common Tomcat Paths:**
- Windows (Chocolatey): `C:\ProgramData\chocolateyinstall\lib\tomcat\`
- Windows (Manual): `C:\Program Files\Apache Software Foundation\Tomcat 9.0\`
- Windows (ZIP): `D:\apache-tomcat-9.x.x\`
- Linux: `/opt/tomcat/`

#### Step 5.2: Configure Tomcat for Web Application

##### Option A: Copy Context Configuration File
```powershell
# Set your Tomcat path
$TOMCAT_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"

# Copy context configuration
Copy-Item "tomcat-context.xml" "$TOMCAT_HOME\conf\Catalina\localhost\student-management.xml"
```

##### Option B: Create Context File Manually

Create file: `$TOMCAT_HOME\conf\Catalina\localhost\student-management.xml`

```xml
<?xml version='1.0' encoding='utf-8'?>
<Context path="/student-management" docBase="student-management" debug="0">
</Context>
```

### Phase 6: Deploy Application

#### Step 6.1: Copy WAR File to Tomcat

```powershell
# Set your Tomcat path
$TOMCAT_HOME = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"

# Copy WAR file
Copy-Item "target\student-management.war" "$TOMCAT_HOME\webapps\"

# Verify
ls "$TOMCAT_HOME\webapps\student-management.war"
```

#### Step 6.2: Verify Tomcat webapps Folder

Navigate to: `$TOMCAT_HOME\webapps\`

Should contain:
- `student-management.war` (new file)
- `student-management/` (auto-extracted folder will be created when Tomcat starts)

### Phase 7: Start Tomcat Server

#### Step 7.1: Start Tomcat (Windows)

**Option A: Using batch file (Recommended)**
```powershell
# Open Command Prompt or PowerShell as Administrator
# Navigate to Tomcat
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"

# Start Tomcat
.\startup.bat

# You should see Tomcat starting up in a new window
```

**Option B: Using Windows Service**
```powershell
# If installed as service
net start Tomcat9

# Or using PowerShell
Start-Service -Name Tomcat9
```

#### Step 7.2: Start Tomcat (Linux/Mac)

```bash
cd /opt/tomcat/bin
./startup.sh

# Or using service
sudo systemctl start tomcat
```

#### Step 7.3: Verify Tomcat Is Running

```powershell
# Wait 10-15 seconds for Tomcat to fully start
Start-Sleep -Seconds 15

# Check Tomcat is listening on port 8080
netstat -ano | findstr :8080

# Or try to access Tomcat homepage
Invoke-WebRequest -Uri "http://localhost:8080"
```

### Phase 8: Verify Application Deployment

#### Step 8.1: Check Tomcat Logs

```powershell
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\logs"

# View latest logs
Get-Content "catalina*.log" -Tail 50 -Wait
```

Look for messages like:
```
INFO: Deployment of web application at context path [/student-management] has finished in XXX ms
```

#### Step 8.2: Access the Application

Open web browser and navigate to:
```
http://localhost:8080/student-management/
```

You should see:
- Student Management System homepage
- Navigation menu with Students and Branches
- Dashboard cards

### Phase 9: Test Application

#### Step 9.1: Test View Students
1. Click "Students" → "View All Students"
2. Should display table with sample students

#### Step 9.2: Test Add Student
1. Click "Students" → "Add Student"
2. Choose "Full Time Student"
3. Fill in form with test data
4. Click "Add Student"
5. Verify message: "Full-time student added successfully!"

#### Step 9.3: Test Sort Functionality
1. Click "Students" → "Sort by ID"
2. Verify students are sorted by ID

#### Step 9.4: Test Branch Management
1. Click "Branches" → "View All Branches"
2. Should display sample branches
3. Click "Add Branch" to test adding new branch

### Phase 10: Troubleshooting

#### Issue: Port 8080 Already in Use

**Solution:** Change Tomcat port

1. Edit: `$TOMCAT_HOME\conf\server.xml`
2. Find line: `<Connector port="8080"`
3. Change to: `<Connector port="8081"`
4. Restart Tomcat
5. Access: `http://localhost:8081/student-management/`

#### Issue: Database Connection Error

**Solution:** Verify database connection

```powershell
# Test MySQL connection
mysql -u root -p -e "USE student_management; SELECT COUNT(*) FROM student;"

# Update DatabaseConnection.java with correct credentials
# Rebuild and redeploy
```

#### Issue: 404 - Application Not Found

**Solution:** Verify deployment

```powershell
# Check if WAR file was deployed
ls "$TOMCAT_HOME\webapps\student-management\"

# Check Tomcat logs
Get-Content "$TOMCAT_HOME\logs\catalina.out" -Tail 50

# Restart Tomcat
.\shutdown.bat
Start-Sleep -Seconds 5
.\startup.bat
```

#### Issue: Application Shows but Database Error

**Solution:** Check database configuration

1. Verify MySQL is running: `mysql -u root -p`
2. Verify database exists: `SHOW DATABASES;`
3. Verify tables exist: `USE student_management; SHOW TABLES;`
4. Check `DatabaseConnection.java` has correct credentials
5. Verify MySQL driver in pom.xml

#### Issue: Servlet or Page Not Found (500 error)

**Solution:** Check Tomcat logs

```powershell
# Tail Tomcat logs
Get-Content "$TOMCAT_HOME\logs\catalina.out" -Wait

# Look for full stack trace
# Common issues:
# - Missing servlet mapping in web.xml
# - Incorrect JSP path
# - Missing dependency
```

### Phase 11: Production Deployment (Optional)

#### Considerations for Production:
1. Enable HTTPS/SSL
2. Configure connection pooling
3. Enable caching
4. Set up monitoring
5. Configure log rotation
6. Use environment variables for credentials
7. Set up regular database backups

#### Enable HTTPS in Tomcat

1. Generate self-signed certificate
2. Update `server.xml` with SSL connector
3. Configure in `web.xml`

Detailed guide: [Tomcat SSL Configuration](https://tomcat.apache.org/tomcat-9.0-doc/ssl-howto.html)

### Phase 12: Stopping and Restarting

#### Stop Tomcat

```powershell
cd "$TOMCAT_HOME\bin"
.\shutdown.bat
```

#### Restart Tomcat

```powershell
.\shutdown.bat
Start-Sleep -Seconds 5
.\startup.bat
```

#### Clean Restart (Remove cached files)

```powershell
cd "$TOMCAT_HOME"
Remove-Item "webapps\student-management" -Recurse -Force
Copy-Item "targets\student-management.war" "webapps\"
.\bin\startup.bat
```

### Verification Checklist

- [ ] Java 11+ installed and verified
- [ ] Maven installed and verified
- [ ] MySQL installed and running
- [ ] Database `student_management` created
- [ ] Student and Branch tables created with sample data
- [ ] DatabaseConnection.java updated with correct credentials
- [ ] WAR file built successfully: `target/student-management.war`
- [ ] WAR file copied to Tomcat webapps folder
- [ ] Tomcat started and running
- [ ] Application accessible at `http://localhost:8080/student-management/`
- [ ] Can view, add, and delete students
- [ ] Can manage branches
- [ ] Database operations work without errors

### Support and Logs Location

**Tomcat Logs:**
```
$TOMCAT_HOME\logs\
- catalina.out (main Tomcat log)
- catalina.YYYY-MM-DD.log
- localhost.YYYY-MM-DD.log
```

**MySQL Logs:**
```
MySQL Data Directory\
- error.log
- mysql.log
```

**Application Logs:**
Check Tomcat logs for application-specific messages

### Next Steps After Successful Deployment

1. Configure backups for database
2. Set up monitoring
3. Create admin user (if features added)
4. Configure email for notifications
5. Set up automated reports
6. Document custom configurations
7. Plan for scaling if needed

## Quick Troubleshooting Commands

```powershell
# Check if port is in use
netstat -ano | findstr :8080

# Kill process on port
taskkill /PID <PID> /F

# Reset Tomcat
Remove-Item "$TOMCAT_HOME\webapps\student-management*" -Recurse -Force

# Rebuild and deploy
cd D:\Student_Management
mvn clean package
Copy-Item "target\student-management.war" "$TOMCAT_HOME\webapps\"
```

For additional support, check README.md and SETUP_GUIDE.md files.
