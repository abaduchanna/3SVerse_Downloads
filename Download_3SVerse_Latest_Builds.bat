@echo off
setlocal EnableExtensions enabledelayedexpansion
title 3SVerse Latest Builds Downloader (VDS + VidaPay + GFH)

rem ================================================================
rem  Downloads the LATEST release build (.exe) of every VDS, VidaPay
rem  and GFH tool into  %USERPROFILE%\Downloads\GitHub
rem
rem  - VDS x3, GFH x8 and VidaPay Transfer Bot: pulled from each
rem    repo's "latest" GitHub release (public, no login needed)
rem  - VidaPay Incentive Extractor / Device Ordering / Rebate Filing:
rem    pulled from the public mirror repo 3SVerse_Downloads, which
rem    auto-syncs the newest build of each tool every 4 hours
rem    (so a build that just shipped can take up to 4h to appear)
rem
rem  Needs: Windows 10 1803+ (built-in curl.exe) and internet.
rem  To change the destination folder, edit the DEST line below.
rem ================================================================

set "DEST=%USERPROFILE%\Downloads\GitHub"
if not exist "%DEST%" mkdir "%DEST%"

where curl.exe >nul 2>nul
if errorlevel 1 (
    echo  [X] curl.exe not found - Windows 10 1803+ includes it built-in.
    echo      Update Windows or install curl, then re-run this file.
    pause
    exit /b 1
)

echo.
echo  ============================================================
echo   3SVerse Latest Builds Downloader
echo   Families : VDS + VidaPay + GFH  (15 tools)
echo   Dest     : %DEST%
echo  ============================================================
echo.

set /a OK=0
set /a FAIL=0

echo  [VidaPay] licensed tools - public mirror (3SVerse_Downloads):
call :dl "https://github.com/abaduchanna/3SVerse_Downloads/releases/latest/download/VidaPay_Incentive_Extractor.exe"
call :dl "https://github.com/abaduchanna/3SVerse_Downloads/releases/latest/download/VidaPay_Device_Ordering.exe"
call :dl "https://github.com/abaduchanna/3SVerse_Downloads/releases/latest/download/VidaPay_Rebate_Filing.exe"

echo.
echo  [VDS] latest releases:
call :repo VDS_Rebate_Tools
call :repo VDS_UPS_Tracking_Checker
call :repo VDS_Xls_To_Xlsx

echo.
echo  [VidaPay] latest release:
call :repo VidaPay_Transfer_Bot

echo.
echo  [GFH] latest releases:
call :repo GFH_Rebate_Tools
call :repo GFH_Xls_To_Xlsx
call :repo GFH_UPS_Tracking_Checker
call :repo GFH_Inventory_Aging_Processor
call :repo GFH_Inventory_Audit
call :repo GFH_Audit_Automation
call :repo GFH_Accessories_Ordering
call :repo GFH_Accessories_Order_History_Scraper

echo.
echo  ============================================================
echo   Summary:  !OK! downloaded,  !FAIL! failed
echo   Location: %DEST%
echo  ============================================================
echo.
pause
exit /b 0

:repo
rem %1 = repo name under github.com/abaduchanna/ - fetch its latest
rem release via the GitHub API and download every .exe asset.
set "REPO=%~1"
echo   Resolving %REPO% (latest release)...
for /f "usebackq delims=" %%U in (`powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { (Invoke-RestMethod -Uri 'https://api.github.com/repos/abaduchanna/%REPO%/releases/latest' -Headers @{ 'User-Agent' = '3sverse-dl' } -TimeoutSec 30).assets | Where-Object { $_.name -like '*.exe' } | ForEach-Object { $_.browser_download_url } } catch { }"`) do (
    call :dl "%%U"
)
exit /b 0

:dl
rem %1 = direct download URL - saves to DEST (via .part then rename)
set "URL=%~1"
for %%F in ("%URL:/=" "%") do set "FNAME=%%~F"
if not defined FNAME exit /b 0
echo   Downloading %FNAME% ...
curl.exe -L --fail --retry 3 --retry-delay 2 --progress-bar -o "%DEST%\%FNAME%.part" "%URL%"
if errorlevel 1 (
    echo     [X] FAILED: %FNAME%
    del /q "%DEST%\%FNAME%.part" 2>nul
    set /a FAIL+=1
) else (
    move /y "%DEST%\%FNAME%.part" "%DEST%\%FNAME%" >nul
    echo     [OK] %FNAME%
    set /a OK+=1
)
set "FNAME="
exit /b 0
