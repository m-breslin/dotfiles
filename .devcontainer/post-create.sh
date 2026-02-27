#!/usr/bin/env bash
# Post-create script for devcontainer
# Runs automatically after devcontainer is created

set -e

echo "🚀 Setting up PyQuant dotfiles in devcontainer..."

# Get the dotfiles repo path
DOTFILES_REPO="${DOTFILES_REPO:=/workspaces/dotfiles}"

# Make sure install script is executable
chmod +x "$DOTFILES_REPO/install.sh"

# Run the install script
"$DOTFILES_REPO/install.sh"

# Additional devcontainer-specific setup
echo ""
echo "📦 Devcontainer-specific setup..."

# Ensure /etc/shells includes zsh for devcontainer
ZSH_PATH=$(which zsh)
if [ -f /etc/shells ] && ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells > /dev/null
fi

# Create a welcome message
cat > ~/.welcome.sh << 'EOF'
#!/usr/bin/env bash
echo ""
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║           Welcome to PyQuant Dotfiles Dev Environment            ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo ""
echo "Your development environment has been configured with:"
echo "  ✓ Zsh shell with advanced configuration"
echo "  ✓ Git aliases and workflow optimization"
echo "  ✓ Vim with improved settings"
echo "  ✓ Dev aliases and utility functions"
echo ""
echo "Available commands:"
echo "  gs    - git status"
echo "  ga    - git add"
echo "  gc    - git commit"
echo "  gp    - git push"
echo "  gcp   - git commit and push"
echo "  dps   - docker ps"
echo "  dlogs - docker logs -f"
echo ""
echo "For more shortcuts, check your zsh config files!"
echo ""
EOF

chmod +x ~/.welcome.sh

# Add welcome message to .zshrc if not already there
if ! grep -q "~/.welcome.sh" ~/.zshrc; then
    echo "" >> ~/.zshrc
    echo "# Display welcome message" >> ~/.zshrc
    echo "[ -f ~/.welcome.sh ] && ~/.welcome.sh" >> ~/.zshrc
fi

echo ""
echo "✅ DevContainer setup complete!"
echo ""
echo "ℹ️  Quick start:"
echo "   Type 'zsh' to start using Zsh configuration"
echo "   or restart your terminal"
echo ""
