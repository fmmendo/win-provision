<#
    Back up current VS Code + Windows Terminal config into the repo.

    Usage:
      .\backup.ps1          # write changes, then review & commit yourself
      .\backup.ps1 -Push    # also commit + push
#>
param([switch]$Push)

$repoRoot = $PSScriptRoot
$codeUser = Join-Path $env:APPDATA 'Code\User'
$wtState  = Join-Path $env:LOCALAPPDATA 'Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'

Write-Host "**********************************************" -ForegroundColor Blue
Write-Host "*       Backing Up configuration files       *" -ForegroundColor Blue
Write-Host "**********************************************" -ForegroundColor Blue

# Plain extension list. Curated "maybe" extensions live in extensions.optional.txt
# (never written here), so this no longer clobbers any hand-kept notes.
Write-Host ".: Exporting VS Code extensions ... " -NoNewline
if (Get-Command code -ErrorAction SilentlyContinue) {
    $exts = code --list-extensions
    if ($exts) { $exts | Set-Content -Path (Join-Path $repoRoot 'vscode\extensions.txt') }  # guard: don't blank the list
    Write-Host "DONE" -ForegroundColor Green
}
else {
    Write-Host "SKIPPED ('code' not on PATH)" -ForegroundColor Yellow
}

Write-Host ".: Exporting VS Code keybindings ... " -NoNewline
Copy-Item (Join-Path $codeUser 'keybindings.json') (Join-Path $repoRoot 'vscode\keybindings.json') -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting VS Code settings ... " -NoNewline
Copy-Item (Join-Path $codeUser 'settings.json') (Join-Path $repoRoot 'vscode\settings.json') -Force
Write-Host "DONE" -ForegroundColor Green

Write-Host ".: Exporting Windows Terminal settings ... " -NoNewline
if (Test-Path $wtState) {
    Copy-Item $wtState (Join-Path $repoRoot 'terminal\settings.json') -Force
    Write-Host "DONE" -ForegroundColor Green
}
else {
    Write-Host "SKIPPED (not found)" -ForegroundColor Yellow
}

if ($Push) {
    git -C $repoRoot commit -am "new backup"
    git -C $repoRoot push origin master
}
else {
    Write-Host "`nDone. Review the changes, then commit (or re-run with -Push)." -ForegroundColor Green
}
