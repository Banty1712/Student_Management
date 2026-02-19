# **Student Management System - Manual Setup Guide**

This document provides step-by-step instructions to manually run the Student Management System application.

---

## **Prerequisites**

Make sure you have installed the following on your system:
- **Java JDK 11** or higher
- **Apache Tomcat 9.0** or higher
- **MySQL Server 5.7** or higher
- **Maven 3.6** or higher

Verify installations:
```powershell
java -version
mvn -version
mysql --version
```

---

## **Step 1: Start MySQL Service**

```powershell
net start MySQL80
```

**Expected Output:**
```
The MySQL80 service is starting.
The MySQL80 service has been started successfully.
```

---

## **Step 2: Create Database and Tables**

Navigate to the project directory and execute the database setup script:

```powershell
& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p"admin" < "D:\Student_Management\database-setup.sql"
```

**Database Credentials:**
- Username: `root`
- Password: `admin`
- Database: `student_management`

**Tables Created:**
- `branch` - Stores branch information
- `student` - Stores student information

---

## **Step 3: Insert Sample Data (Optional)**

To populate the database with sample branches and students:

```powershell
Get-Content "D:\Student_Management\insert-sample-data.sql" | & "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p"admin" student_management
```

**Data Included:**
- 6 Branches (CS, IT, EC, ME, CE, BA)
- 10 Student records with complete information

---

## **Step 4: Build the Application with Maven**

Navigate to the project root directory and build:

```powershell
cd D:\Student_Management
mvn clean package -DskipTests
```

**What this does:**
- Cleans previous build artifacts
- Compiles Java source code
- Packages application as WAR file
- Output: `D:\Student_Management\target\student-management.war`

**Expected Output:**
```
[INFO] BUILD SUCCESS
[INFO] Total time: 9.276 s
```

---

## **Step 5: Configure Java Home Environment**

Set the JAVA_HOME environment variable:

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-24"
```

Or use your JDK installation path if different.

---

## **Step 6: Stop Tomcat (if already running)**

```powershell
cd C:\tools\tomcat\bin
.\catalina.bat stop
Start-Sleep -Seconds 3
```

---

## **Step 7: Deploy Application to Tomcat**

**Remove old deployment:**
```powershell
Remove-Item "C:\tools\tomcat\webapps\student-management" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\tools\tomcat\webapps\student-management.war" -Force -ErrorAction SilentlyContinue
```

**Copy new WAR file:**
```powershell
Copy-Item "D:\Student_Management\target\student-management.war" "C:\tools\tomcat\webapps\"
```

Tomcat will automatically extract and deploy the WAR file.

---

## **Step 8: Start Tomcat Server**

```powershell
$env:JAVA_HOME = "C:\Program Files\Java\jdk-24"
cd C:\tools\tomcat\bin
Start-Process catalina.bat -ArgumentList "start" -WindowStyle Hidden
Start-Sleep -Seconds 5
```

**Wait 5-10 seconds** for Tomcat to fully start and deploy the application.

---

## **Step 9: Access the Application**

Open your web browser and navigate to:

```
http://localhost:8080/student-management/
```

**You should see the Student Management System homepage.**

---

## **Application Features**

### **Home Page**
- Navigation menu with all options
- Quick access to students and branches

### **Manage Branches**
- View all branches
- Add new branch
- Delete branch
- View branch details

### **Manage Students**
- View all students
- Add new student
- Delete student
- Sort students by ID, date, or name
- View student details

---

## **Troubleshooting**

| Problem | Solution |
|---------|----------|
| MySQL connection denied | Verify password is `admin` and MySQL is running: `net start MySQL80` |
| Port 8080 already in use | Stop other Tomcat instances or change port in `server.xml` |
| JAR/Dependencies not found | Run `mvn clean package` to download dependencies |
| JAVA_HOME not set | Set: `$env:JAVA_HOME = "C:\Program Files\Java\jdk-24"` |
| Application not loading | Wait 10 seconds for Tomcat deployment, check logs |
| Database not found | Execute: database-setup.sql first |

---

## **Viewing Logs**

**Tomcat Application Logs:**
```powershell
Get-Content "C:\tools\tomcat\logs\catalina.*.log" -Tail 20
```

**Database Connection Logs:**
```powershell
Get-Content "C:\tools\tomcat\logs\database-connection.log" -Tail 20
```

---

## **Stopping the Application**

**Stop Tomcat:**
```powershell
cd C:\tools\tomcat\bin
.\catalina.bat stop
```

**Stop MySQL:**
```powershell
net stop MySQL80
```

---

## **Project Structure**

```
D:\Student_Management/
├── src/
│   ├── database/          # Database connection code
│   ├── model/            # Data models (Student, Branch)
│   ├── service/          # Business logic
│   ├── web/              # Servlets
│   └── setup/            # Setup classes
├── web/
│   ├── WEB-INF/          # Configuration
│   ├── css/              # Stylesheets
│   └── *.jsp             # Web pages
├── target/               # Build output
├── pom.xml               # Maven configuration
├── database-setup.sql    # Database creation script
├── insert-sample-data.sql # Sample data
└── README.md             # Project documentation
```

---

## **Important Paths**

| Item | Path |
|------|------|
| Project Root | `D:\Student_Management` |
| Source Code | `D:\Student_Management\src` |
| WAR File | `D:\Student_Management\target\student-management.war` |
| Tomcat Home | `C:\tools\tomcat` |
| Tomcat Logs | `C:\tools\tomcat\logs` |
| MySQL Bin | `C:\Program Files\MySQL\MySQL Server 8.0\bin` |

---

## **Quick Start All-in-One Command**

Combine all steps (run in PowerShell as Administrator):

```powershell
# Start MySQL
net start MySQL80

# Navigate to project
cd D:\Student_Management

# Build
mvn clean package -DskipTests

# Deploy
$env:JAVA_HOME = "C:\Program Files\Java\jdk-24"
Remove-Item "C:\tools\tomcat\webapps\student-management*" -Recurse -Force -ErrorAction SilentlyContinue
Copy-Item "D:\Student_Management\target\student-management.war" "C:\tools\tomcat\webapps\"

# Start Tomcat
cd C:\tools\tomcat\bin
Start-Process catalina.bat -ArgumentList "start" -WindowStyle Hidden
Start-Sleep -Seconds 5

Write-Host "Application ready at: http://localhost:8080/student-management/" -ForegroundColor Green
```

---

## **Support**

For more information, check:
- [README.md](README.md) - Project overview
- [SETUP_GUIDE.md](SETUP_GUIDE.md) - Initial setup guide
- [DEPLOYMENT_INSTRUCTIONS.md](DEPLOYMENT_INSTRUCTIONS.md) - Deployment details
- GitHub: https://github.com/Banty1712/Student_Management

---

**Happy coding! 🎉**
