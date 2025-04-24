@echo off
:: administrator privileges
fltmc >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo error: right-click on the script and select "Run as administrator"
        pause
    )
    exit /b 1
)

pushd %~dp0

:: Check for required files
for %%a in ("amifldrv64.sys", "amigendrv64.sys", "nvram.txt", "SCEWIN_64.exe") do (
    if not exist "%%~a" (
        echo error: %%~a not found in the current directory

        if "%%~a" == "nvram.txt" (
            echo Please rename your NVRAM script file to "nvram.txt" or run "Export.bat" to create it
        )

        pause
        exit /b 1    
    )    
)

:: Run the import
SCEWIN_64.exe /I /S nvram.txt 2> log-file.txt
type log-file.txt
echo See log-file.txt for output messages
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
cls
echo ============================
echo       Backup Successful
echo ============================
echo Press Any Key To Continue...
echo ============================
pause >nul
cls
echo ============================
echo         Restarting...
echo ============================
timeout /t 2 /nobreak >nul
shutdown /r /t 0 