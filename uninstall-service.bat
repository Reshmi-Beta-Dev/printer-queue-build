@echo off
echo Uninstalling Print Queue Monitor Service...

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as Administrator
    pause
    exit /b 1
)

REM Stop the service
echo Stopping service...
sc stop "PrintQueueMonitor"

REM Delete the service
echo Removing service...
sc delete "PrintQueueMonitor"

if %errorLevel% neq 0 (
    echo Failed to remove service
    pause
    exit /b 1
)

echo Service uninstalled successfully!
pause

