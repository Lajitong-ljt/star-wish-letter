@echo off
rem ============================================================
rem  Starfield - local launcher
rem  Double-click: starts local server + opens browser
rem ============================================================
setlocal enabledelayedexpansion

set "PORT=8888"
set "ROOT=%~dp0"
set "URL=http://127.0.0.1:%PORT%/"
set "PUBLIC_URL=https://frp-bar.com:46887"

echo [1/3] Checking port %PORT%...
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":%PORT% " ^| findstr "LISTENING"') do (
    echo      Port %PORT% in use by PID %%a, stopping it...
    taskkill /F /PID %%a >nul 2>&1
)
timeout /t 1 /nobreak >nul

echo [2/3] Starting local server on port %PORT%...
start "stars-server" /min cmd /c "cd /d ""%ROOT%"" && npx --yes http-server -p %PORT% --silent"

echo [3/3] Waiting for server (max 15s)...
set /a tries=0
:waitloop
timeout /t 1 /nobreak >nul
curl -s -o nul http://127.0.0.1:%PORT%/
if errorlevel 1 (
    set /a tries+=1
    if !tries! lss 15 goto waitloop
    echo      Server failed to start. Check network and try again.
    pause
    exit /b 1
)

echo.
echo   Ready! Opening browser...
start "" "%URL%"
echo.
echo   If browser did not open, visit: %URL%
echo.
echo   ==================================================
echo    Share with phone / friends (public link):
echo    %PUBLIC_URL%
echo.
echo    First visit: browser warns about certificate,
echo    click Advanced - Continue anyway.
echo    (The page itself is served from this PC via frp)
echo   ==================================================
echo.
echo   Press any key to close this window (page stays open).
pause >nul
