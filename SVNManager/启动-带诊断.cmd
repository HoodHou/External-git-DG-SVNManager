@echo off
setlocal
cd /d "%~dp0"

set "LOCAL_LOG=%~dp0diagnostic.log"
set "STARTUP_LOG=%APPDATA%\SVNManager\startup.log"

echo Dream SVN Manager diagnostic > "%LOCAL_LOG%"
echo Time: %DATE% %TIME% >> "%LOCAL_LOG%"
echo CurrentDir: %CD% >> "%LOCAL_LOG%"
echo User: %USERNAME% >> "%LOCAL_LOG%"
echo Computer: %COMPUTERNAME% >> "%LOCAL_LOG%"
echo OS: %OS% >> "%LOCAL_LOG%"
echo Processor: %PROCESSOR_ARCHITECTURE% >> "%LOCAL_LOG%"
echo. >> "%LOCAL_LOG%"

echo ==========================================
echo Dream SVN Manager diagnostic
echo ==========================================
echo Current directory:
echo %CD%
echo.
echo Diagnostic log:
echo %LOCAL_LOG%
echo.

if not exist "SVNManager.exe" (
  echo ERROR: SVNManager.exe was not found.
  echo ERROR: SVNManager.exe was not found. >> "%LOCAL_LOG%"
  echo Please unzip the whole package before running this file.
  echo.
  pause
  exit /b 1
)

echo Files near SVNManager.exe: >> "%LOCAL_LOG%"
dir /b >> "%LOCAL_LOG%" 2>&1
echo. >> "%LOCAL_LOG%"

echo Starting SVNManager.exe...
echo Starting SVNManager.exe... >> "%LOCAL_LOG%"
start "" "%~dp0SVNManager.exe"

echo Waiting 5 seconds...
timeout /t 5 /nobreak >nul

tasklist /fi "imagename eq SVNManager.exe" | find /i "SVNManager.exe" >nul
if errorlevel 1 (
  echo.
  echo The program is not running after startup.
  echo The program is not running after startup. >> "%LOCAL_LOG%"
) else (
  echo.
  echo The program process is running. If you still cannot see a window, send a screenshot of this window and diagnostic.log.
  echo The program process is running. >> "%LOCAL_LOG%"
)

echo. >> "%LOCAL_LOG%"
echo App startup log: %STARTUP_LOG% >> "%LOCAL_LOG%"
if exist "%STARTUP_LOG%" (
  echo.
  echo Last startup log:
  echo Last startup log: >> "%LOCAL_LOG%"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Content -LiteralPath $env:APPDATA'\SVNManager\startup.log' -Tail 120" >> "%LOCAL_LOG%" 2>&1
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-Content -LiteralPath $env:APPDATA'\SVNManager\startup.log' -Tail 40" 2>nul
) else (
  echo.
  echo No startup.log found yet.
  echo No startup.log found yet. >> "%LOCAL_LOG%"
)

echo.
echo Done. Please send diagnostic.log if the program did not open.
echo Done. >> "%LOCAL_LOG%"
pause
