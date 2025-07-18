@echo off
rem START or STOP Services
rem ----------------------------------
rem Check if argument is STOP or START

if not ""%1"" == ""START"" goto stop

if exist E:\Data-Science\XAMMP\hypersonic\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\server\hsql-sample-database\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\ingres\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\ingres\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\mysql\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\mysql\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\postgresql\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\postgresql\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\apache\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\apache\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\openoffice\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\openoffice\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\apache-tomcat\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\apache-tomcat\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\resin\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\resin\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\jetty\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\jetty\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\subversion\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\subversion\scripts\ctl.bat START)
rem RUBY_APPLICATION_START
if exist E:\Data-Science\XAMMP\lucene\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\lucene\scripts\ctl.bat START)
if exist E:\Data-Science\XAMMP\third_application\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\third_application\scripts\ctl.bat START)
goto end

:stop
echo "Stopping services ..."
if exist E:\Data-Science\XAMMP\third_application\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\third_application\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\lucene\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\lucene\scripts\ctl.bat STOP)
rem RUBY_APPLICATION_STOP
if exist E:\Data-Science\XAMMP\subversion\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\subversion\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\jetty\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\jetty\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\hypersonic\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\server\hsql-sample-database\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\resin\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\resin\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\apache-tomcat\scripts\ctl.bat (start /MIN /B /WAIT E:\Data-Science\XAMMP\apache-tomcat\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\openoffice\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\openoffice\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\apache\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\apache\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\ingres\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\ingres\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\mysql\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\mysql\scripts\ctl.bat STOP)
if exist E:\Data-Science\XAMMP\postgresql\scripts\ctl.bat (start /MIN /B E:\Data-Science\XAMMP\postgresql\scripts\ctl.bat STOP)

:end

