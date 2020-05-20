Write-Host "Provisioning machine" -ForegroundColor Yellow

# Note, this may need to be run BEFORE this script
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore

Write-Host "System Configuration" -ForegroundColor Yellow
#--- Enable developer mode on the system ---
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1

#--- Configuring Windows properties ---
#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
#Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# Install Chocolatey
# Set-ExecutionPolicy Bypass -Scope Process -Force;
# [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
# iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# # Install Nuget provider if needed
# $providers = Get-PackageProvider | Select-Object Name
# if (-not ($providers.Name.Contains("NuGet"))) {
#     Write-Host "NuGet not installed, installing..." -ForegroundColor Yellow
#     Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.208 -Force | Out-Null
# }

# # Install Chocolatey provider if needed
# if (-not ($providers.Name.Contains("Chocolatey"))) {
#     Write-Host "NuGet not installed, installing..." -ForegroundColor Yellow
#     Install-PackageProvider -Name Chocolatey -MinimumVersion 2.8.5.130 -Force | Out-Null
# }

winget install terminal
winget install vscode
winget install Microsoft.VisualStudio.Community
winget install git
winget install GitHub.GitHubDesktop
winget install 7zip
winget install DockerDesktop
winget install Microsoft.PowerToys
winget install node
python
winget install wsl
# winget install whatsapp

# additional configuration
# install vscode extensions (see vscode.ps1)
# install visual studio components

# Things not yet covered by winget
# choco install -y git --package-parameters="'/GitAndUnixToolsOnPath /WindowsTerminal'"
choco install -y fiddler
choco install -y microsoft-edge-insider-dev

# other apps
# - power toys
# - utorrent
# - monogame sdk
# - Polar Flow
# - Skype (desktop)
# - WinMerge
# - LinqPad

# store apps
# - heif
# - hevc
# - Microsoft To Do
# - Netflix
# - NextGen Reader
# - OneNote for Windows 10
# - spotify
# - Skype (Store app)
# - Xbox
# - Xbox Console Companion
# - Xbox Smartglass