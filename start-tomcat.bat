@echo off
REM Start Apache Tomcat Server
REM Navigate to Tomcat home directory
cd C:\tools\tomcat\bin

REM Start Tomcat
call catalina.bat start

REM Wait a moment for server to start
timeout /t 3

REM Open browser (optional)
start http://localhost:8080/student-management/

REM Display status message
echo.
echo ============================================
echo Tomcat server started!
echo ============================================
echo Application URL: http://localhost:8080/student-management/
echo Logs location: C:\tools\tomcat\logs\
echo.
echo Press Ctrl+C in the terminal to stop server
pause
