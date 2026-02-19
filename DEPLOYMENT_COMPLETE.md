# Student Management - Deployment Guide

## Current Status ✅

- **Build**: ✅ COMPLETE (student-management.war created)
- **Tomcat**: ✅ INSTALLED at C:\tools\tomcat
- **WAR Deployed**: ✅ READY at C:\tools\tomcat\webapps\student-management.war
- **Database**: ⏳ PENDING (MySQL setup required)

---

## Step 1: Install MySQL Community Server (If Not Already Installed)

### Option A: Download MySQL Installer
1. Download MySQL Community Server 8.0 from: https://dev.mysql.com/downloads/mysql/
2. Run the installer (mysql-installer-community-8.0.xx.msi)
3. Follow the Setup Wizard:
   - Choose "Server only" for a lightweight installation
   - Use default port: **3306**
   - Configure MySQL Server as a Windows Service (automatic startup)
   - Set Root password (remember this!)
   - Recommended: root username, password: **root123**

### Option B: Verify MySQL Installation
Open PowerShell and run:
```powershell
mysql --version
```

---

## Step 2: Create Database and Tables

### Method 1: Using SQL Script (Recommended)
Open **Command Prompt** and run:
```cmd
cd D:\Student_Management
mysql -u root -p < database-setup.sql
```
When prompted, enter your MySQL root password.

### Method 2: Using MySQL Command Line
1. Open Command Prompt
2. Connect to MySQL:
   ```cmd
   mysql -u root -p
   ```
3. Enter your password
4. Run the SQL commands from `D:\Student_Management\database-setup.sql`

### Verify Database Creation
In MySQL shell:
```sql
SHOW DATABASES;
USE student_mgmt;
SHOW TABLES;
SELECT COUNT(*) FROM student;
SELECT COUNT(*) FROM branch;
```

### Expected Results
- Database: `student_mgmt` created
- Tables: `branch`, `student` (with sample data)
- Sample data: 5 branches, 10 students

---

## Step 3: Update Database Connection (If Using Non-Default Credentials)

If you used different MySQL credentials, update:
`D:\Student_Management\src/database/DatabaseConnection.java`

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/student_mgmt";
private static final String DB_USER = "root";        // Change if different
private static final String DB_PASSWORD = "root123"; // Change if different
```

Then rebuild:
```cmd
cd D:\Student_Management
C:\tools\maven\bin\mvn.cmd clean package -DskipTests
```

---

## Step 4: Start Tomcat Server

### Quick Start
Double-click:
```
D:\Student_Management\start-tomcat.bat
```

### Manual Start
```cmd
cd C:\tools\tomcat\bin
catalina.bat start
```

The server will start on port **8080**.

---

## Step 5: Access the Application

Open your web browser and navigate to:
```
http://localhost:8080/student-management/
```

### Expected Pages
- **Home**: Dashboard with navigation
- **Students**: View, add, delete, sort students
- **Branches**: View, add, delete branches
- **Details Pages**: View individual student/branch information

---

## Step 6: Stop Tomcat Server

### Quick Stop
Double-click:
```
D:\Student_Management\stop-tomcat.bat
```

### Manual Stop
```cmd
cd C:\tools\tomcat\bin
catalina.bat stop
```

---

## Troubleshooting

### Problem: "Port 8080 already in use"
**Solution**: Change Tomcat port in `C:\tools\tomcat\conf\server.xml`:
```xml
<Connector port="8081" protocol="HTTP/1.1" ...>
```
Then access at: `http://localhost:8081/student-management/`

### Problem: "Database connection failed"
1. Verify MySQL is running:
   ```cmd
   mysql --version
   ```
2. Check credentials in `DatabaseConnection.java`
3. Verify database exists:
   ```cmd
   mysql -u root -p -e "SHOW DATABASES;"
   ```

### Problem: "Application showing blank page or 404"
1. Check Tomcat logs: `C:\tools\tomcat\logs\catalina.out`
2. Verify WAR file exists: `C:\tools\tomcat\webapps\student-management.war`
3. Wait 10-15 seconds for WAR extraction and app startup

### Problem: "ClassNotFoundException or dependency issues"
1. Rebuild the project:
   ```cmd
   cd D:\Student_Management
   C:\tools\maven\bin\mvn.cmd clean package -DskipTests
   ```
2. Redeploy the new WAR file:
   ```cmd
   Copy-Item "D:\Student_Management\target\student-management.war" "C:\tools\tomcat\webapps\" -Force
   ```
3. Restart Tomcat

---

## Project Structure

```
D:\Student_Management\
├── src/
│   ├── database/           # Database connection classes
│   ├── model/              # Student, Branch models  
│   ├── service/            # Business logic
│   ├── setup/              # Setup utilities
│   ├── ui/                 # Console UI (deprecated)
│   └── web/                # Servlets (StudentServlet, BranchServlet, etc.)
├── web/
│   ├── css/                # Stylesheet (style.css)
│   └── *.jsp               # JSP pages (index, student-list, branch-list, etc.)
├── target/
│   └── student-management.war  # Packaged application
├── pom.xml                 # Maven configuration
├── web.xml                 # Servlet configuration
├── database-setup.sql      # Database initialization script
└── start-tomcat.bat        # Startup script
```

---

## Key URLs and Endpoints

| Feature | URL |
|---------|-----|
| Home | http://localhost:8080/student-management/ |
| Student List | http://localhost:8080/student-management/student/list |
| Add Student | http://localhost:8080/student-management/student/add |
| Branch List | http://localhost:8080/student-management/branch/list |
| Add Branch | http://localhost:8080/student-management/branch/add |

---

## Environment Details

- **Java Version**: 24.0.2
- **Maven Version**: 3.9.6 (at C:\tools\maven)
- **Tomcat Version**: 11.0.2 (at C:\tools\tomcat)
- **MySQL Version**: 8.0+ (recommended)
- **Database Name**: student_mgmt
- **JDBC Driver**: mysql-connector-java 8.0.33

---

## Database Schema

### branch table
```sql
CREATE TABLE branch (
  branchId INT PRIMARY KEY AUTO_INCREMENT,
  branchName VARCHAR(100) UNIQUE NOT NULL,
  location VARCHAR(100),
  contact VARCHAR(50)
);
```

### student table
```sql
CREATE TABLE student (
  studentId INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  phone VARCHAR(20),
  studentType VARCHAR(20),
  branchId INT NOT NULL,
  FOREIGN KEY (branchId) REFERENCES branch(branchId)
);
```

---

## Next Steps

1. ✅ Install MySQL
2. ✅ Run database setup script
3. ✅ Start Tomcat
4. ✅ Test application
5. 🔧 Customize as needed

Happy deploying! 🚀
