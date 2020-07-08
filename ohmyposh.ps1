Write-Host "************************************" -ForegroundColor Blue
Write-Host "*        Setting up Terminal       *" -ForegroundColor Blue
Write-Host "************************************" -ForegroundColor Blue


# Install/Set-Up oh-my-posh
Write-Host " - Installing dependencies ... " -NoNewline
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSReadLine -Scope CurrentUser -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host " - Setting up theme ... " -NoNewline
Set-Prompt
Set-Theme Agnoster
Write-Host "DONE" -ForegroundColor Green

Write-Host " - Configuring PowerShell profile ... " -NoNewline
if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }

Add-Content $profile "Import-Module posh-git"
Add-Content $profile "Import-Module oh-my-posh"
Add-Content $profile "Set-Theme Agnoster"
Write-Host "DONE" -ForegroundColor Green

# Install Cascadia Code
# 1. Download Cascadia Code font from GitHub
Write-Host " - Downloading CascadiaCode from github ... " -NoNewline
$DLPath = "https://github.com/microsoft/cascadia-code/releases/download/v2005.15/CascadiaCode_2005.15.zip"
$DLFile = '.\terminal\cascadia.zip'
Invoke-WebRequest -Uri $DLPath -OutFile $DLFile
Write-Host "DONE" -ForegroundColor Green

# 2. Extract files
Expand-Archive -Path $DLFile -DestinationPath '.\terminal\cascadia\'

# 3. Install fonts
Write-Host " - Installing fonts ... " -NoNewline

$FONTS = 0x14
$Path = ".\terminal\cascadia\otf\"
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$Fontdir = Get-ChildItem $Path
foreach ($File in $Fontdir) {
    if (!($file.name -match "pfb$")) {
        $try = $true
        $installedFonts = @(Get-ChildItem c:\windows\fonts | Where-Object { $_.PSIsContainer -eq $false } | Select-Object basename)
        $name = $File.baseName

        foreach ($font in $installedFonts) {
            $font = $font -replace "_", ""
            $name = $name -replace "_", ""
            if ($font -match $name) {
                $try = $false
            }
        }
        if ($try) {
            $objFolder.CopyHere($File.fullname)
        }
    }
}
Write-Host "DONE" -ForegroundColor Green
