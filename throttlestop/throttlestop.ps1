#Checks if the user is in the administrator group. Warns and stops if the user is not.
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You are not running this as local administrator. Run it again in an elevated prompt." ; break
}
else {
    Write-Host ".: Unpacking ThrottleStop... " -NoNewline
    Expand-Archive -Path .\throttlestop\ts.zip -DestinationPath C:\Users\fmmen\Documents\
    Write-Host "DONE" -ForegroundColor Green

    # Write-Host ".: Adding ThrottleStop shortcut to StartUp... " -NoNewline
    # $SourceFileLocation = "C:\Users\fmmen\Documents\ThrottleStop\ThrottleStop.exe"
    # $ShortcutLocation = "C:\Users\fmmen\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ThrottleStop.lnk"
    # $WScriptShell = New-Object -ComObject WScript.Shell
    # $Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
    # $Shortcut.TargetPath = $SourceFileLocation
    # $Shortcut.Save()
    # Write-Host "DONE" -ForegroundColor Green

    Write-Host ".: Adding ThrottleStop to TaskScheduler... " -NoNewline
    $action = New-ScheduledTaskAction -Execute 'C:\Users\fmmen\Documents\ThrottleStop\ThrottleStop.exe'
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    Register-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -TaskPath "My Tasks" -TaskName "ThrottleStopRunner" -Description "Run ThrottleStop at Startup"
    Write-Host "DONE" -ForegroundColor Green
}