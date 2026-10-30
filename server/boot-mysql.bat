@echo off
taskkill /F /IM mysqld.exe >nul 2>&1
timeout /t 3 /nobreak >nul
start "" /MIN "C:\Program Files\MySQL\MySQL Server 8.4\bin\mysqld.exe" --defaults-file=E:\wow\server\my.ini
timeout /t 12 /nobreak >nul
"C:\Program Files\MySQL\MySQL Server 8.4\bin\mysqladmin.exe" -uroot ping
"C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe" -uroot -e "SELECT id,username FROM acore_auth.account; SELECT id,gmlevel,RealmID FROM acore_auth.account_access;"
exit /b %ERRORLEVEL%
