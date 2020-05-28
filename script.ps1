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
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

Write-Host "STEP 2 : Installing Applications" -ForegroundColor Yellow

# --- WINGET installs ---
winget install terminal
winget install vscode
winget install Microsoft.VisualStudio.Community
winget install git
winget install GitHub.GitHubDesktop

winget install 7zip
winget install Microsoft.PowerToys
winget install fiddler
winget install linqpad
winget install WinMerge
winget install Microsoft.EdgeDev
winget install whatsapp
winget install spotify
winget install skype # desktop

winget install DockerDesktop
winget install node
# winget install python
# winget install wsl
# winget install Microsoft.OneDrive

# --- additional configuration ---
# install vscode extensions (see vscode.ps1)
# install visual studio components

# Things not yet covered by winget ??
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