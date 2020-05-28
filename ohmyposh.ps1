# Install/Set-Up oh-my-posh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSReadLine -Scope CurrentUser -Force

Set-Prompt
Set-Theme Agnoster

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }

Add-Content $profile "Import-Module posh-git"
Add-Content $profile "Import-Module oh-my-posh"
Add-Content $profile "Set-Theme Agnoster"

# # Install Cascadia Code
# # 1. Download Cascadia Code font from GitHub
# $DLPath = "https://github.com/microsoft/cascadia-code/releases/download/v2005.15/CascadiaCode_2005.15.zip"
# $DLFile = 'C:\Foo\Cascadia.TTF'
# Invoke-WebRequest -Uri $DLPath -OutFile $DLFile

# # 2. Now Install the Font 
# $Font = New-Object -Com Shell.Application
# $Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
# $Destination.CopyHere($DLFile,0x10)