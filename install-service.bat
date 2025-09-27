@echo off
echo Installing Print Queue Monitor Service...

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo This script must be run as Administrator
    pause
    exit /b 1
)

REM Build the application
echo Building application...
dotnet build --configuration Release

if %errorLevel% neq 0 (
    echo Build failed
    pause
    exit /b 1
)

REM Create the service
echo Creating Windows Service...
sc create "PrintQueueMonitor" binPath="%CD%\bin\Release\net6.0-windows\PrintQueueMonitor.exe --service" start=auto DisplayName="Print Queue Monitor Service"

if %errorLevel% neq 0 (
    echo Failed to create service
    pause
    exit /b 1
)

REM Start the service
echo Starting service...
sc start "PrintQueueMonitor"

if %errorLevel% neq 0 (
    echo Failed to start service
    pause
    exit /b 1
)

echo Service installed and started successfully!
echo Service will monitor print queue and save jobs to: C:\PrintQueueJobs
pause

