@echo off

if not ""%1"" == ""START"" goto stop

cmd.exe /C start /B /MIN "" "E:\Data-Science\XAMMP\apache\bin\httpd.exe"

if errorlevel 255 goto finish
if errorlevel 1 goto error
goto finish

:stop
cmd.exe /C start "" /MIN call "E:\Data-Science\XAMMP\killprocess.bat" "httpd.exe"

if not exist "E:\Data-Science\XAMMP\apache\logs\httpd.pid" GOTO finish
del "E:\Data-Science\XAMMP\apache\logs\httpd.pid"
goto finish

:error
echo Error starting Apache

:finish
exit
