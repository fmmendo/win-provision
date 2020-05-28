Write-Host "**********************************************" -ForegroundColor Blue
Write-Host "*       Backing Up configuration files       *" -ForegroundColor Blue
Write-Host "**********************************************" -ForegroundColor Blue

Write-Host ".: Generating VS Code Extensions Installation file ... " -NoNewline
code --list-extensions | % { "code --install-extension $_" } > .\vscode\vscode.ps1
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting VS Code KeyBindings ... " -NoNewline
Copy-Item "%UserProfile%\AppData\Roaming\Code\User\keybindings.json" -Destination ".\vscode\keybindings.json" -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting VS Code Settings ... " -NoNewline
Copy-Item "%UserProfile%\AppData\Roaming\Code\User\settings.json" -Destination ".\vscode\settings.json" -Force
Write-Host "DONE" -ForegroundColor Green