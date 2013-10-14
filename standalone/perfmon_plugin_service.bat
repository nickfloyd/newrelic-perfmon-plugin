@echo off
set plugin_exec=perfmon_plugin_standalone.exe

cd /D "%~dp0"
IF [%1] == [] GOTO usage
IF "%1" == "start" GOTO start_this
IF "%1" == "stop" GOTO stop_this
IF "%1" == "usage" GOTO usage
GOTO usage

:start_this
start /b %plugin_exec%
GOTO end_this

:stop_this
rem TASKKILL /F /IM %plugin_exec%
for /f %%G in (ruby.pid) do (TASKKILL /F /PID %%G)
GOTO end_this

:usage
echo perfmon_plugin_service.bat [start/stop/usage]

:end_this