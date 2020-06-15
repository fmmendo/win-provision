# import custom menu
. .\testmenu.ps1

Write-Host "************************************" -ForegroundColor Blue
Write-Host "*       Provisioning machine       *" -ForegroundColor Blue
Write-Host "************************************" -ForegroundColor Blue

Write-Host "STEP 1 : System Configuration" -ForegroundColor Yellow

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore


# --- Enable developer mode on the system ---
Write-Host " - Enabling Developer Mode ... " -NoNewline
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
Write-Host "DONE" -ForegroundColor Green

# --- Configuring Windows properties ---
# --- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Write-Host " - Show Hidden files and folders, OS Files, and file extensions ... " -NoNewline
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
Write-Host "DONE" -ForegroundColor Green

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Write-Host " - Set up Task Bar for multi-monitor ... " -NoNewline
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2
Write-Host "DONE" -ForegroundColor Green

Write-Host "STEP 2 : Installing Applications" -ForegroundColor Yellow

# --- WINGET installs ---
winget install terminal -e
winget install Microsoft.VisualStudioCode -e
winget install Microsoft.VisualStudio.Community -e
winget install Git.Git --override /GitAndUnixToolsOnPath --override /WindowsTerminal -e
winget install GitHub.GitHubDesktop -e

winget install 7zip -e
winget install Microsoft.PowerToys -e
winget install fiddler -e
winget install linqpad -e
winget install WinMerge -e
winget install Microsoft.EdgeDev -e
winget install whatsapp -e
winget install Spotify.Spotify -e
winget install skype -e # desktop

winget install DockerDesktop -e
winget install node -e
# winget install python
# winget install wsl
# winget install Microsoft.OneDrive

# --- additional configuration ---
# install visual studio components

# choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"

# other apps
# - utorrent
# - monogame sdk
# - Polar Flow

# store apps
# - heif
# - hevc
# - Microsoft To Do
# - Netflix
# - NextGen Reader
# - OneNote for Windows 10
# - Skype (Store app)
# - Xbox
# - Xbox Console Companion
# - Xbox Smartglass

# --- Install VS Code Extensions
Write-Host "STEP 3 : Configuring VS Code" -ForegroundColor Yellow
. .\vscode\vscode.ps1

Write-Host ".: Configuring VS Code Key Bindings ... " -NoNewline
Copy-Item ".\vscode\keybindings.json" -Destination "%UserProfile%\AppData\Roaming\Code\User\keybindings.json" -Force
Write-Host "DONE" -ForegroundColor Green
Write-Host ".: Configuring VS Code Settings ... " -NoNewline
Copy-Item ".\vscode\settings.json" -Destination "%UserProfile%\AppData\Roaming\Code\User\settings.json" -Force
Write-Host "DONE" -ForegroundColor Green

# --- Configure Windows Terminal / Powershell
Write-Host "STEP 4 : Configuring Windows Terminal" -ForegroundColor Yellow
. .\ohmyposh.ps1


# $option = New-BinaryMenu -Title 'Something' -Question 'Do you want to install X?'

# if ($option) {
# Write-Host "Recevied: " -NoNewline
# Write-Host $option
# }