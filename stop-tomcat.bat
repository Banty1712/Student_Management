@echo off
REM Stop Apache Tomcat Server
cd C:\tools\tomcat\bin

REM Stop Tomcat
call catalina.bat stop

REM Wait for graceful shutdown
timeout /t 5

echo.
echo ============================================
echo Tomcat server stopped!
echo ============================================
echo.
pause
