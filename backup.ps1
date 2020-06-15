Write-Host "**********************************************" -ForegroundColor Blue
Write-Host "*       Backing Up configuration files       *" -ForegroundColor Blue
Write-Host "**********************************************" -ForegroundColor Blue

Write-Host ".: Generating VS Code Extensions Installation file ... " -NoNewline
code --list-extensions | ForEach-Object { "code --install-extension $_" } > .\vscode\vscode.ps1
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting VS Code KeyBindings ... " -NoNewline
Copy-Item "C:\Users\fmmen\AppData\Roaming\Code\User\keybindings.json" -Destination ".\vscode\keybindings.json" -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting VS Code Settings ... " -NoNewline
Copy-Item "C:\Users\fmmen\AppData\Roaming\Code\User\settings.json" -Destination ".\vscode\settings.json" -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting Windows Terminal Settings ... " -NoNewline
Copy-Item "C:\Users\fmmen\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Destination ".\terminal\settings.json" -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Backing Up ThrottleStop... " -NoNewline
Compress-Archive -Path C:\Users\fmmen\Documents\ThrottleStop -DestinationPath .\throttlestop\ts.zip
Write-Host "DONE" -ForegroundColor Green

git commit -am "new backup"
git push origin master

Write-Host "**********************************************" -ForegroundColor Blue
Write-Host "*              Back Up Complete              *" -ForegroundColor Blue
Write-Host "**********************************************" -ForegroundColor Blue
