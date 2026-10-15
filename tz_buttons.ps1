Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles() | Out-Null

# Keep the script ASCII-only so it works consistently in Windows PowerShell 5.1.
function D($b64) {
    return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64))
}

$config = @{
    chinaTz = "China Standard Time"
    usTz = "Pacific Standard Time"
}

function Get-Tz {
    $out = & tzutil /g 2>$null
    return ([string]$out).Trim()
}

function Set-Tz($name) {
    & tzutil /s $name 2>$null
    return ($LASTEXITCODE -eq 0)
}

function Invoke-Switch($mode) {
    $target = if ($mode -eq 'china') { $config.chinaTz } else { $config.usTz }
    if (Set-Tz $target) {
        return ((D "5pe25Yy65bey6K6+5Li6IA==") + $target + "`n" + (D "5b2T5YmN5pe25Yy677ya") + (Get-Tz))
    }
    return (D "6K6+572u5pe25Yy65aSx6LSl77yI5Y+v6IO96ZyA6KaB566h55CG5ZGY5p2D6ZmQ77yJ")
}

function Show-ResultToast($msg) {
    try {
        $toastForm = New-Object System.Windows.Forms.Form
        $toastForm.WindowState = 'Minimized'
        $toastForm.ShowInTaskbar = $false
        $notify = New-Object System.Windows.Forms.NotifyIcon
        $notify.Icon = [System.Drawing.SystemIcons]::Information
        $notify.Visible = $true
        $notify.BalloonTipTitle = D "5pe25Yy65YiH5o2i"
        $notify.BalloonTipText = $msg
        $notify.ShowBalloonTip(3500)
        $timer = New-Object System.Windows.Forms.Timer
        $timer.Interval = 4000
        $timer.add_Tick({ $notify.Dispose(); $toastForm.Close() })
        $timer.Start()
        [System.Windows.Forms.Application]::Run($toastForm)
    } catch {
        [System.Windows.Forms.MessageBox]::Show($msg, (D "5pe25Yy65YiH5o2i"), "OK") | Out-Null
    }
}

function Show-Error($msg) {
    try {
        [System.Windows.Forms.MessageBox]::Show($msg, (D "5pe25Yy65YiH5o2i"), "OK", "Error") | Out-Null
    } catch { }
    try {
        ($msg + "`r`n" + (Get-Date)) | Out-File -FilePath (Join-Path $env:TEMP "iseacat_timezone_switcher_error.log") -Append -Encoding UTF8
    } catch { }
}

$argAction = $args | Where-Object { $_ -in @('china', 'us') } | Select-Object -First 1
if ($argAction) {
    try { Show-ResultToast (Invoke-Switch $argAction) }
    catch { Show-Error ((D "5ZCv5Yqo5aSx6LSl77ya") + $_.Exception.Message) }
    return
}

$form = New-Object System.Windows.Forms.Form
$form.Text = D "aVNlYWNhdCDml7bljLrliIfmjaI="
$form.FormBorderStyle = 'FixedToolWindow'
$form.TopMost = $true
$form.BackColor = [System.Drawing.Color]::FromArgb(28, 32, 40)
$form.Width = 280
$form.Height = 150
$form.StartPosition = 'CenterScreen'

$bChina = New-Object System.Windows.Forms.Button
$bChina.Text = D "5YiH5Lit5Zu9"
$bChina.Location = New-Object System.Drawing.Point(12, 12)
$bChina.Size = New-Object System.Drawing.Size(116, 42)
$bChina.BackColor = [System.Drawing.Color]::FromArgb(225, 29, 72)
$bChina.ForeColor = [System.Drawing.Color]::White
$bChina.FlatStyle = 'Flat'

$bUs = New-Object System.Windows.Forms.Button
$bUs.Text = D "5YiH576O5Zu9"
$bUs.Location = New-Object System.Drawing.Point(136, 12)
$bUs.Size = New-Object System.Drawing.Size(116, 42)
$bUs.BackColor = [System.Drawing.Color]::FromArgb(37, 99, 235)
$bUs.ForeColor = [System.Drawing.Color]::White
$bUs.FlatStyle = 'Flat'

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(12, 66)
$label.Size = New-Object System.Drawing.Size(240, 38)
$label.ForeColor = [System.Drawing.Color]::FromArgb(209, 250, 229)
$label.Text = (D "5bCx57uq")

$worker = New-Object System.ComponentModel.BackgroundWorker
$worker.add_DoWork({ param($sender, $event) $event.Result = Invoke-Switch $event.Argument })
$worker.add_RunWorkerCompleted({
    param($sender, $event)
    if ($event.Error) { $label.Text = $event.Error.Message } else { $label.Text = $event.Result }
    $bChina.Enabled = $true
    $bUs.Enabled = $true
})

function Start-Action($mode) {
    if ($worker.IsBusy) { return }
    $bChina.Enabled = $false
    $bUs.Enabled = $false
    $label.Text = D "5aSE55CG5LitLi4u"
    $worker.RunWorkerAsync($mode)
}

$bChina.Add_Click({ Start-Action 'china' })
$bUs.Add_Click({ Start-Action 'us' })
$form.Controls.AddRange(@($bChina, $bUs, $label))

try {
    if ($env:TZ_BUTTONS_TEST -ne '1') { $form.ShowDialog() | Out-Null }
} catch {
    Show-Error ((D "5ZCv5Yqo5aSx6LSl77ya") + $_.Exception.Message)
}

