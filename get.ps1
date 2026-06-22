<#
    get.ps1 - one-line bootstrap for a fresh machine (no Git required).

    A clean Windows install has winget + PowerShell but NOT Git, so you can't clone
    the repo to get script.ps1. This downloads the repo as a zip instead, then runs it.

    Run straight from the web:
      irm https://raw.githubusercontent.com/fmmendo/win-provision/master/get.ps1 | iex
#>

$ErrorActionPreference = 'Stop'

$repo    = 'fmmendo/win-provision'
$branch  = 'master'
$dest    = Join-Path $env:USERPROFILE 'win-provision'
$zip     = Join-Path $env:TEMP 'win-provision.zip'
$extract = Join-Path $env:TEMP 'win-provision-extract'

# Allow the downloaded script.ps1 (a file) to run in this user's context.
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore

Write-Host "Downloading $repo ($branch)..." -ForegroundColor Cyan
Invoke-WebRequest "https://github.com/$repo/archive/refs/heads/$branch.zip" -OutFile $zip -UseBasicParsing

if (Test-Path $extract) { Remove-Item $extract -Recurse -Force }
Expand-Archive $zip -DestinationPath $extract -Force

# The zip extracts to an inner '<repo>-<branch>' folder; move it to $dest.
$inner = Get-ChildItem $extract -Directory | Select-Object -First 1
if (Test-Path $dest) { Remove-Item $dest -Recurse -Force }
Move-Item $inner.FullName $dest

Remove-Item $zip, $extract -Recurse -Force -ErrorAction Ignore

Set-Location $dest
Write-Host "Fetched to $dest - running script.ps1`n" -ForegroundColor Cyan
& .\script.ps1
