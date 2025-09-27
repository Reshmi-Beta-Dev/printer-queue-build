@echo off
echo Print Queue Monitor - Portable Installer
echo ======================================
echo.
echo This will install Print Queue Monitor as a Windows Service.
echo You must run this as Administrator.
echo.
pause

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as Administrator
    pause
    exit /b 1
)

echo Installing Print Queue Monitor Service...
sc create "PrintQueueMonitor" binPath="%CD%\PrintQueueMonitor.exe --service" start=auto DisplayName="Print Queue Monitor Service"

if %errorLevel% neq 0 (
    echo Failed to create service
    pause
    exit /b 1
)

echo Starting service...
sc start "PrintQueueMonitor"

if %errorLevel% neq 0 (
    echo Failed to start service
    pause
    exit /b 1
)

echo.
echo Installation completed successfully!
echo.
echo The Print Queue Monitor service is now running.
echo Print jobs will be saved to: C:\PrintQueueJobs
echo.
echo To uninstall, run: uninstall-service.bat
echo To run in console mode, run: run-console.bat
echo.
pause
