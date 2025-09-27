@echo off
echo Starting Print Queue Monitor in Console Mode...
echo Press Ctrl+C to stop
echo.

REM Build the application
dotnet build --configuration Release

if %errorLevel% neq 0 (
    echo Build failed
    pause
    exit /b 1
)

REM Run in console mode
dotnet run --configuration Release

