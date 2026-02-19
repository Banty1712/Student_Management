# Quick Setup Guide for Student Management System

## Prerequisites Installation

### 1. Install Java Development Kit (JDK)

**Windows:**
- Download JDK 11 or higher from [Oracle](https://www.oracle.com/java/technologies/downloads/) or [OpenJDK](https://jdk.java.net/)
- Run installer and follow instructions
- Add to PATH (usually automatic)
- Verify: Open PowerShell and run: `java -version`

**Alternative - Using Chocolatey (Windows):**
```powershell
choco install openjdk11
```

### 2. Install Maven

**Windows:**
- Download Maven from [maven.apache.org](https://maven.apache.org/download.cgi)
- Extract to a folder (e.g., `C:\maven`)
- Add Maven `bin` directory to PATH
- Verify: Open PowerShell and run: `mvn -version`

**Alternative - Using Chocolatey (Windows):**
```powershell
choco install maven
```

### 3. Install Apache Tomcat

**Windows:**
- Download Tomcat 9.0 or higher from [tomcat.apache.org](https://tomcat.apache.org/download-90.cgi)
- Extract to a folder (e.g., `C:\Program Files\Apache Software Foundation\Tomcat 9.0`)
- No installation needed for ZIP version

**Alternative - Using Chocolatey (Windows):**
```powershell
choco install tomcat
```

### 4. Install MySQL Server

**Windows:**
- Download MySQL Community Edition from [mysql.com](https://dev.mysql.com/downloads/mysql/)
- Run installer and follow instructions
- Note username and password (default: root / root)
- Start MySQL Service

**Alternative - Using Chocolatey (Windows):**
```powershell
choco install mysql
```

## Quick Start

### Step 1: Setup Database

1. Open MySQL command line or MySQL Workbench
2. Execute the SQL commands from `docs/database-setup.sql` or:

```sql
CREATE DATABASE student_management;
USE student_management;

CREATE TABLE branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    branch_code VARCHAR(20) NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15),
    branch_id INT,
    cgpa DECIMAL(3,2),
    enrollment_date DATE,
    student_type VARCHAR(20),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

-- Insert sample branches
INSERT INTO branch (branch_name, branch_code, department) VALUES
('Computer Science', 'CS', 'Engineering'),
('Information Technology', 'IT', 'Engineering'),
('Electronics', 'EC', 'Engineering');
```

### Step 2: Update Database Credentials

Edit `src/database/DatabaseConnection.java`:

```java
private static final String URL = "jdbc:mysql://localhost:3306/student_management";
private static final String USER = "root";
private static final String PASSWORD = "your_password";
```

### Step 3: Build the Application

```powershell
cd D:\Student_Management
.\build.ps1 -Action build
```

### Step 4: Deploy to Tomcat

1. Copy `target\student-management.war` to `$TOMCAT_HOME\webapps\`
   - Example: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\`

2. Rename the file to `student-management.war`

### Step 5: Start Tomcat Server

**Windows (Command Prompt as Administrator):**
```cmd
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
startup.bat
```

**Windows (PowerShell as Administrator):**
```powershell
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
.\startup.bat
```

### Step 6: Access the Application

Open your web browser and go to:
```
http://localhost:8080/student-management/
```

## Troubleshooting

### Maven not found
- Make sure Maven is installed and its `bin` folder is in PATH
- Restart PowerShell/CMD after adding to PATH

### Java version error
- Make sure JDK (not JRE) is installed
- Set JAVA_HOME environment variable to JDK directory

### Port 8080 already in use
- Configure Tomcat to use different port in `conf/server.xml`
- Or close application using port 8080

### Cannot connect to database
- Ensure MySQL is running
- Check database credentials in `DatabaseConnection.java`
- Verify database `student_management` exists

### Application shows 404 error
- Ensure WAR file is in Tomcat `webapps` folder
- Check Tomcat logs in `logs` folder
- Ensure context path is `/student-management`

## Build Commands

```powershell
# Build WAR package
.\build.ps1 -Action build

# Clean build artifacts
.\build.ps1 -Action clean

# Compile only
.\build.ps1 -Action compile

# Show help
.\build.ps1 -Action help
```

## Project Structure After Build

```
target/
├── student-management/
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   ├── classes/         # Compiled Java files
│   │   └── lib/             # JAR dependencies
│   ├── css/
│   ├── js/
│   ├── *.jsp                # JSP pages
│   └── index.jsp
└── student-management.war   # Deployable WAR file
```

## Next Steps

1. Add sample data through the web interface
2. Explore features: Add students, manage branches
3. Review CSS in `web/css/style.css` for customization
4. Extend functionality with new features

## Support Resources

- [Apache Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)
- [Maven Documentation](https://maven.apache.org/guides/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Java Servlet Documentation](https://docs.oracle.com/cd/E17409_01/wlp/wlp131/proprefx/taskdescriptionsde637a57bc0d4625-16ac.html)
