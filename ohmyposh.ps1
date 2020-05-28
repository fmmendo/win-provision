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