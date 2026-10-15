@echo off
set "SRC=%~dp0"
set "INSTALL=%LOCALAPPDATA%\iSeacatTimezoneSwitcher"
if not exist "%INSTALL%" mkdir "%INSTALL%"
copy /Y "%SRC%tz_buttons.ps1" "%INSTALL%\"
copy /Y "%SRC%switch-china.bat" "%INSTALL%\"
copy /Y "%SRC%switch-us.bat" "%INSTALL%\"
copy /Y "%SRC%run-tray.bat" "%INSTALL%\"
powershell -NoProfile -ExecutionPolicy Bypass -File "%SRC%make-shortcuts.ps1"
echo Install finished. Desktop shortcuts: Ctrl+Alt+C = China, Ctrl+Alt+U = US
pause

