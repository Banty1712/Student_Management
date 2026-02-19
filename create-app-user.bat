@echo off
echo Creating MySQL 'appuser' with mysql_native_password authentication...
echo.

REM Create new application user with mysql_native_password
echo Creating user 'appuser'@'localhost' with password 'apppass123'...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "CREATE USER IF NOT EXISTS 'appuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'apppass123'; GRANT ALL PRIVILEGES ON student_management.* TO 'appuser'@'localhost'; FLUSH PRIVILEGES;" 2>&1

echo.
echo Verifying appuser was created...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u root -padmin -e "SELECT user, plugin FROM mysql.user WHERE user='appuser';" 2>&1

echo.
echo Testing connection with appuser...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -h localhost -u appuser -papppass123 -e "SELECT 'appuser can connect!' as result; SELECT COUNT(*) as branch_count FROM student_management.branch;" 2>&1

echo.
echo User creation complete!
