Add-Type -AssemblyName System.Windows.Forms

function D($b64) {
    return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64))
}

$china = D "5YiH5Lit5Zu9"
$us = D "5YiH576O5Zu9"
$install = Join-Path $env:LOCALAPPDATA "iSeacatTimezoneSwitcher"
$desktop = [Environment]::GetFolderPath('Desktop')
$shell = New-Object -ComObject WScript.Shell

$chinaShortcut = $shell.CreateShortcut((Join-Path $desktop ($china + ".lnk")))
$chinaShortcut.TargetPath = Join-Path $install "switch-china.bat"
$chinaShortcut.Hotkey = "CTRL+ALT+C"
$chinaShortcut.Description = "Switch to China Standard Time"
$chinaShortcut.Save()

$usShortcut = $shell.CreateShortcut((Join-Path $desktop ($us + ".lnk")))
$usShortcut.TargetPath = Join-Path $install "switch-us.bat"
$usShortcut.Hotkey = "CTRL+ALT+U"
$usShortcut.Description = "Switch to US Pacific Time"
$usShortcut.Save()

