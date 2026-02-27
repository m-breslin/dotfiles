# Install script wrapper for Windows PowerShell
# Run with: powershell -ExecutionPolicy Bypass -File install.ps1

Write-Host "`n===============================================" -ForegroundColor Blue
Write-Host "PyQuant Dotfiles Installation for Windows" -ForegroundColor Blue
Write-Host "===============================================`n" -ForegroundColor Blue

# Check if bash is available
$bashPath = Get-Command bash -ErrorAction SilentlyContinue

if (-not $bashPath) {
    Write-Host "ERROR: Git Bash or WSL not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install one of:" -ForegroundColor Yellow
    Write-Host "- Git for Windows (includes Git Bash): https://git-scm.com/download/win" -ForegroundColor Yellow
    Write-Host "- Windows Subsystem for Linux (WSL): wsl --install" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

# Get the directory where this script is located
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Running install script..." -ForegroundColor Green
Write-Host ""

# Run the install script with bash
& bash "$scriptDir\install.sh"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Installation failed!" -ForegroundColor Red
    Write-Host "Please check the output above for details." -ForegroundColor Red
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "===============================================" -ForegroundColor Green
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "===============================================`n" -ForegroundColor Green

Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Restart your terminal/PowerShell" -ForegroundColor Yellow
Write-Host "2. Or run: bash" -ForegroundColor Yellow
Write-Host "3. Then run: exec zsh" -ForegroundColor Yellow
Write-Host ""
