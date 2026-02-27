#!/usr/bin/env bash
# Install script for dotfiles
# Works on Linux, WSL, and macOS
# Automatically sets up symlinks and configures shell

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the script directory (where this script is located)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_REPO="${SCRIPT_DIR}"

echo -e "${BLUE}=== Dotfiles Installation Script ===${NC}"
echo -e "${BLUE}Installing from: ${DOTFILES_REPO}${NC}\n"

# Function to create symlink
create_symlink() {
    local src="$1"
    local dest="$2"
    local name="$3"

    if [ -e "$dest" ]; then
        if [ -L "$dest" ]; then
            # Already a symlink, check if it points to the right place
            local target=$(readlink "$dest")
            if [ "$target" = "$src" ]; then
                echo -e "${GREEN}✓${NC} $name already linked correctly"
                return 0
            else
                echo -e "${YELLOW}⚠${NC} $name symlink points to wrong location, removing old link"
                rm "$dest"
            fi
        else
            # File exists but is not a symlink
            echo -e "${YELLOW}⚠${NC} $name exists but is not a symlink, backing up to $dest.bak"
            mv "$dest" "$dest.bak"
        fi
    fi

    ln -s "$src" "$dest"
    echo -e "${GREEN}✓${NC} Created symlink for $name"
}

# Function to detect OS
detect_os() {
    case "$(uname -s)" in
        Linux*)     echo "Linux";;
        Darwin*)    echo "macOS";;
        MINGW*|MSYS*|CYGWIN*) echo "Windows";;
        *)          echo "Unknown";;
    esac
}

# Function to check if running in devcontainer
is_devcontainer() {
    [ -f "/.dockerenv" ] && [ -d "/workspaces" ]
}

# Function to install Zsh
install_zsh() {
    if command -v zsh &> /dev/null; then
        echo -e "${GREEN}✓${NC} Zsh is already installed"
        return 0
    fi

    echo -e "${YELLOW}Installing Zsh...${NC}"

    local os=$(detect_os)
    case "$os" in
        Linux)
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y zsh
            elif command -v apk &> /dev/null; then
                sudo apk add zsh
            elif command -v yum &> /dev/null; then
                sudo yum install -y zsh
            else
                echo -e "${RED}✗${NC} Could not install Zsh on this Linux distribution"
                return 1
            fi
            ;;
        macOS)
            if command -v brew &> /dev/null; then
                brew install zsh
            else
                echo -e "${RED}✗${NC} Homebrew not found. Please install Zsh manually."
                return 1
            fi
            ;;
        *)
            echo -e "${RED}✗${NC} Cannot automatically install Zsh on $os"
            return 1
            ;;
    esac

    echo -e "${GREEN}✓${NC} Zsh installed successfully"
}

# Function to set Zsh as default shell
set_zsh_default() {
    local zsh_path=$(command -v zsh)

    if [ "$SHELL" = "$zsh_path" ]; then
        echo -e "${GREEN}✓${NC} Zsh is already set as default shell"
        return 0
    fi

    echo -e "${YELLOW}Setting Zsh as default shell...${NC}"

    # In devcontainers, we may not have permission to chsh
    if is_devcontainer; then
        if grep -q "$zsh_path" /etc/shells 2>/dev/null; then
            chsh -s "$zsh_path" 2>/dev/null || {
                echo -e "${YELLOW}⚠${NC} Could not set Zsh as default shell in devcontainer"
                echo -e "${YELLOW}  Add 'shell: /bin/zsh' to .devcontainer/devcontainer.json instead${NC}"
                return 0
            }
        fi
    else
        chsh -s "$zsh_path"
    fi

    echo -e "${GREEN}✓${NC} Zsh set as default shell"
}

# Create necessary directories
echo -e "${BLUE}Setting up directories...${NC}"
mkdir -p ~/.config/zsh
mkdir -p ~/.config/vim
mkdir -p ~/.config/git

# Create Zsh configuration symlinks
echo -e "\n${BLUE}Setting up Zsh configuration...${NC}"
create_symlink "$DOTFILES_REPO/zsh/.zshrc" ~/.zshrc "~/.zshrc"
create_symlink "$DOTFILES_REPO/zsh/aliases.zsh" ~/.config/zsh/aliases.zsh "~/.config/zsh/aliases.zsh"
create_symlink "$DOTFILES_REPO/zsh/functions.zsh" ~/.config/zsh/functions.zsh "~/.config/zsh/functions.zsh"
create_symlink "$DOTFILES_REPO/zsh/prompt.zsh" ~/.config/zsh/prompt.zsh "~/.config/zsh/prompt.zsh"

# Create Vim configuration symlink
echo -e "\n${BLUE}Setting up Vim configuration...${NC}"
create_symlink "$DOTFILES_REPO/vim/.vimrc" ~/.vimrc "~/.vimrc"

# Create Git configuration symlink
echo -e "\n${BLUE}Setting up Git configuration...${NC}"
create_symlink "$DOTFILES_REPO/git/gitconfig" ~/.gitconfig "~/.gitconfig"

# Install and configure Zsh
echo -e "\n${BLUE}Checking shell environment...${NC}"
install_zsh || echo -e "${YELLOW}⚠${NC} Zsh installation failed, but dotfiles are still configured"
set_zsh_default || echo -e "${YELLOW}⚠${NC} Could not set Zsh as default, but configuration is ready"

# Success message
echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}✓${NC} Dotfiles have been installed successfully!"
echo -e "\n${YELLOW}Next steps:${NC}"

if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo -e "  1. Restart your terminal or run: exec zsh"
    echo -e "  2. Verify everything works with: zsh"
else
    echo -e "  1. Reload your shell configuration: exec zsh"
fi

echo -e "\n${YELLOW}Optional:${NC}"
echo -e "  • For Powerlevel10k integration, follow: https://github.com/romkatv/powerlevel10k"
echo -e "  • Create ~/.zshrc.local for local customizations"
echo -e "\n"
