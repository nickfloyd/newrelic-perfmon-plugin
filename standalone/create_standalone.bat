@echo off
set PLUGIN_EXE_NAME=perfmon_plugin_standalone.exe
set PLUGIN_ICON=windows.ico
cd %~dp0
ocra --gemfile Gemfile --output %PLUGIN_EXE_NAME% --icon %PLUGIN_ICON% perfmon_plugin_multithread.rb perfmon_metrics.rb config/cacert.pem config/perfmon_totals_counters.txt