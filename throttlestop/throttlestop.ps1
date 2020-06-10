Write-Host ".: Unpacking ThrottleStop... " -NoNewline
Expand-Archive -Path .\throttlestop\ts.zip -DestinationPath C:\Users\fmmen\Documents\
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Adding ThrottleStop to StartUp... " -NoNewline
$SourceFileLocation = "C:\Users\fmmen\Documents\ThrottleStop\ThrottleStop.exe"
$ShortcutLocation = "C:\Users\fmmen\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\ThrottleStop.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
$Shortcut.TargetPath = $SourceFileLocation
$Shortcut.Save()
Write-Host "DONE" -ForegroundColor Green