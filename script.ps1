#Requires -Version 5.1
<#
    win-provision - bootstrap a fresh Windows 11 machine.

    Steps:
      1. Apply .config/configuration.winget via `winget configure`
         (installs apps + enables Developer Mode).
      2. Apply a few per-user tweaks winget configure doesn't cover cleanly.
      3. Configure the oh-my-posh prompt + a Nerd Font.
      4. Restore VS Code settings, keybindings and extensions.

    Usage:
      Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore
      .\script.ps1
#>

$repoRoot = $PSScriptRoot
$problems = [System.Collections.Generic.List[string]]::new()

function Invoke-Step {
    param([string]$Name, [scriptblock]$Action)
    Write-Host "`n=== $Name ===" -ForegroundColor Cyan
    try {
        & $Action
        Write-Host "OK" -ForegroundColor Green
    }
    catch {
        Write-Warning "$Name failed: $($_.Exception.Message)"
        $problems.Add($Name)
    }
}

Write-Host "************************************" -ForegroundColor Blue
Write-Host "*       Provisioning machine       *" -ForegroundColor Blue
Write-Host "************************************" -ForegroundColor Blue

# --- 0. Pre-reqs -------------------------------------------------------------
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force -ErrorAction Ignore
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget not found. Install 'App Installer' from the Microsoft Store, then re-run."
}

# --- 1. Apply the declarative configuration ----------------------------------
Invoke-Step "Applying winget configuration (apps + Developer Mode)" {
    $configFile = Join-Path $repoRoot '.config\configuration.winget'
    winget configure --file $configFile --accept-configuration-agreements
    if ($LASTEXITCODE -ne 0) { throw "winget configure exited with code $LASTEXITCODE" }
}

# --- 2. Per-user Windows tweaks (not cleanly covered by DSC) -----------------
Invoke-Step "Applying Explorer / taskbar tweaks" {
    $advanced = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
    Set-ItemProperty -Path $advanced -Name HideFileExt    -Value 0   # show file extensions
    Set-ItemProperty -Path $advanced -Name Hidden         -Value 1   # show hidden files
    Set-ItemProperty -Path $advanced -Name MMTaskbarMode  -Value 2   # multi-monitor: taskbar where window is open
}

# --- 3. oh-my-posh prompt -----------------------------------------------------
Invoke-Step "Configuring oh-my-posh prompt" {
    # oh-my-posh itself is installed by the winget configuration above.
    # Refresh PATH so the freshly-installed exe is visible in this session.
    $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' +
                [Environment]::GetEnvironmentVariable('Path', 'User')

    if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
        throw "oh-my-posh not on PATH yet - open a new terminal and re-run this step."
    }

    oh-my-posh font install CascadiaCode   # installs CaskaydiaCove NF (matches vscode/settings.json)

    if (-not (Test-Path $PROFILE)) { New-Item -ItemType File -Path $PROFILE -Force | Out-Null }
    if (-not (Select-String -Path $PROFILE -SimpleMatch 'oh-my-posh init' -Quiet -ErrorAction SilentlyContinue)) {
        Add-Content -Path $PROFILE -Value ''
        Add-Content -Path $PROFILE -Value 'oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\agnoster.omp.json" | Invoke-Expression'
    }
}

# --- 4. VS Code: settings, keybindings, extensions ---------------------------
Invoke-Step "Configuring VS Code" {
    $codeUserDir = Join-Path $env:APPDATA 'Code\User'
    if (Test-Path $codeUserDir) {
        Copy-Item (Join-Path $repoRoot 'vscode\settings.json')    (Join-Path $codeUserDir 'settings.json')    -Force
        Copy-Item (Join-Path $repoRoot 'vscode\keybindings.json') (Join-Path $codeUserDir 'keybindings.json') -Force
        Write-Host " - settings & keybindings copied"
    }
    else {
        Write-Warning " - VS Code user dir not found; launch VS Code once, then re-run to copy settings."
    }

    $extFile = Join-Path $repoRoot 'vscode\extensions.txt'
    if ((Get-Command code -ErrorAction SilentlyContinue) -and (Test-Path $extFile)) {
        Get-Content $extFile |
            Where-Object { $_.Trim() -and -not $_.Trim().StartsWith('#') } |
            ForEach-Object {
                Write-Host " - extension: $($_.Trim())"
                code --install-extension $_.Trim() --force
            }
    }
    else {
        Write-Warning " - 'code' not on PATH; open a new terminal and run:"
        Write-Warning "     Get-Content vscode\extensions.txt | % { code --install-extension `$_ }"
    }
}

# Note: terminal/settings.json is the old (2020, v1.4) Windows Terminal schema and is
# kept for reference only - it is not auto-restored, as newer Terminal versions differ.

# --- Summary -----------------------------------------------------------------
Write-Host "`n************************************" -ForegroundColor Blue
if ($problems.Count -eq 0) {
    Write-Host "*        Provisioning done!        *" -ForegroundColor Blue
}
else {
    Write-Host "*   Provisioning done with issues  *" -ForegroundColor Blue
}
Write-Host "************************************" -ForegroundColor Blue
if ($problems.Count -gt 0) {
    Write-Host "Steps that need attention:" -ForegroundColor Yellow
    $problems | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
}
Write-Host "Open a new terminal to pick up the oh-my-posh prompt." -ForegroundColor Yellow
