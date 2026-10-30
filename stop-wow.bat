@echo off
title Stop WoW Server
echo Stopping auth/world...
wsl -d Ubuntu -u root -- bash -c "pkill -x worldserver; pkill -x authserver; echo done"
echo Stopping MySQL...
taskkill /F /IM mysqld.exe >nul 2>&1
echo Stopped.
pause