@echo off
powershell -NoProfile -ExecutionPolicy Bypass -STA -WindowStyle Hidden -File "%~dp0tz_buttons.ps1"
if errorlevel 1 (
    echo Start failed. See %TEMP%\iseacat_timezone_switcher_error.log
    pause
)

