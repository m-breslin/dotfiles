#!/usr/bin/env bash
# Post-create script for devcontainer
# Runs automatically after devcontainer is created

set -e

echo "🚀 Setting up PyQuant dotfiles with Oh My Zsh + Powerlevel10k..."

# Get the dotfiles repo path
DOTFILES_REPO="${DOTFILES_REPO:=/workspaces/dotfiles}"

# Make sure install script is executable
chmod +x "$DOTFILES_REPO/install.sh"

# Run the install script (includes Oh My Zsh and Powerlevel10k)
"$DOTFILES_REPO/install.sh"

# Additional devcontainer-specific setup
echo ""
echo "📦 Devcontainer-specific setup..."

# Ensure /etc/shells includes zsh for devcontainer
ZSH_PATH=$(which zsh)
if [ -f /etc/shells ] && ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

echo ""
echo "✅ DevContainer setup complete!"
echo ""
echo "🎉 Your shell now includes:"
echo "   • Powerlevel10k theme with beautiful icons"
echo "   • Oh My Zsh with git, python, and docker plugins"
echo "   • PyQuant dotfiles (aliases, functions, git config)"
echo ""
echo "🚀 Next: Reload your shell or restart your terminal"
echo ""
