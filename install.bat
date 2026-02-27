@echo off
REM Install script wrapper for Windows (Git Bash / WSL)
REM This script simplifies running the install.sh on Windows

setlocal enabledelayedexpansion

echo.
echo ===============================================
echo PyQuant Dotfiles Installation for Windows
echo ===============================================
echo.

REM Check if we have Git Bash or WSL
where /q bash
if errorlevel 1 (
    echo ERROR: Git Bash or WSL not found!
    echo.
    echo Please install one of:
    echo - Git for Windows (includes Git Bash): https://git-scm.com/download/win
    echo - Windows Subsystem for Linux (WSL): wsl --install
    echo.
    pause
    exit /b 1
)

REM Get the directory where this script is located
set SCRIPT_DIR=%~dp0

REM Run the install script with bash
echo Running install script...
echo.

bash "%SCRIPT_DIR%install.sh"

if errorlevel 1 (
    echo.
    echo ERROR: Installation failed!
    echo Please check the output above for details.
    echo.
    pause
    exit /b 1
)

echo.
echo ===============================================
echo Installation complete!
echo ===============================================
echo.
echo Next steps:
echo 1. Restart your terminal/command prompt
echo 2. Or run: bash
echo 3. Then run: exec zsh
echo.
pause
