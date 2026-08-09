@echo off
setlocal EnableExtensions
cd /d "%~dp0"

echo.
echo === Emergency Response — Windows setup ===
echo.

where node >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js is not installed or not in PATH.
  echo Install the LTS version from https://nodejs.org/ then reopen this window.
  pause
  exit /b 1
)

where npm >nul 2>&1
if errorlevel 1 (
  echo ERROR: npm was not found. Reinstall Node.js from https://nodejs.org/
  pause
  exit /b 1
)

echo Node version:
node -v
echo npm version:
npm -v
echo.

cd frontend
if errorlevel 1 (
  echo ERROR: frontend folder not found.
  pause
  exit /b 1
)

if not exist ".env" (
  if exist ".env.example" (
    copy /Y ".env.example" ".env" >nul
    echo Created frontend\.env from .env.example
    echo Edit frontend\.env and add your Supabase URL and anon key before logging in.
    echo.
  )
)

echo Closing common file locks helps avoid EPERM on Windows.
echo Close other terminals using this folder if install fails.
echo.

if exist "node_modules" (
  echo Removing old node_modules...
  rmdir /s /q "node_modules" 2>nul
  if exist "node_modules" (
    echo WARNING: Could not fully delete node_modules ^(EPERM^).
    echo 1^) Close Cursor/VS Code terminals for this project
    echo 2^) Open Task Manager and end Node.js processes
    echo 3^) Reboot if needed, then run setup.bat again
    echo.
  )
)

echo Installing dependencies ^(may take several minutes^)...
echo.

set ATTEMPT=1
:INSTALL
npm install
if not errorlevel 1 goto INSTALL_OK

echo.
echo npm install failed ^(attempt %ATTEMPT%^).
if "%ATTEMPT%"=="3" goto INSTALL_FAIL

set /a ATTEMPT+=1
echo Retrying in 5 seconds...
timeout /t 5 /nobreak >nul
echo Clearing npm cache and retrying...
call npm cache clean --force >nul 2>&1
goto INSTALL

:INSTALL_FAIL
echo.
echo ERROR: npm install failed after 3 attempts.
echo Common causes on Windows:
echo   - Unstable internet ^(ECONNRESET^) — try a hotspot, then run setup.bat again
echo   - Locked files ^(EPERM^) — close editors / end Node.js, then rerun
echo   - Antivirus blocking node_modules writes — allow this folder temporarily
echo.
pause
exit /b 1

:INSTALL_OK
if not exist "node_modules\react-scripts\bin\react-scripts.js" (
  echo.
  echo ERROR: Install finished but react-scripts is missing.
  echo Delete frontend\node_modules and run setup.bat again on a stable network.
  pause
  exit /b 1
)

echo.
echo === Setup OK ===
echo To start the app:
echo   npm start
echo Or from the project root:
echo   npm start
echo.
echo Open http://localhost:3000 after it compiles.
echo.
pause
exit /b 0
