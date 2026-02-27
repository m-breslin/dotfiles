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

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        echo -e "${GREEN}✓${NC} Oh My Zsh is already installed"
        return 0
    fi

    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"

    # Use curl or wget depending on what's available
    if command -v curl &> /dev/null; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    elif command -v wget &> /dev/null; then
        sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo -e "${YELLOW}⚠${NC} Could not install Oh My Zsh (curl or wget required)"
        return 1
    fi

    echo -e "${GREEN}✓${NC} Oh My Zsh installed successfully"
}

# Function to install Powerlevel10k theme
install_powerlevel10k() {
    local p10k_path="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"

    if [[ -d "$p10k_path" ]]; then
        echo -e "${GREEN}✓${NC} Powerlevel10k is already installed"
        return 0
    fi

    echo -e "${YELLOW}Installing Powerlevel10k theme...${NC}"

    if command -v git &> /dev/null; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_path"
        echo -e "${GREEN}✓${NC} Powerlevel10k installed successfully"
    else
        echo -e "${YELLOW}⚠${NC} Could not install Powerlevel10k (git required)"
        return 1
    fi
}

# Create necessary directories
echo -e "${BLUE}Setting up directories...${NC}"
mkdir -p ~/.config/zsh
mkdir -p ~/.config/vim
mkdir -p ~/.config/git

# Mark this repository as safe for Git (fixes "dubious ownership" warnings)
echo -e "\n${BLUE}Setting up Git repository trust...${NC}"
git config --global --add safe.directory "$DOTFILES_REPO" 2>/dev/null || true
echo -e "${GREEN}✓${NC} Repository marked as safe for Git operations"

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
echo -e "\n${BLUE}Setting up shell environment...${NC}"
install_zsh || echo -e "${YELLOW}⚠${NC} Zsh installation failed, but dotfiles are still configured"
set_zsh_default || echo -e "${YELLOW}⚠${NC} Could not set Zsh as default, but configuration is ready"

# Install Oh My Zsh and Powerlevel10k
echo -e "\n${BLUE}Installing Oh My Zsh and Powerlevel10k...${NC}"
install_oh_my_zsh || echo -e "${YELLOW}⚠${NC} Oh My Zsh installation failed, but dotfiles are configured"
install_powerlevel10k || echo -e "${YELLOW}⚠${NC} Powerlevel10k installation skipped, but Oh My Zsh is ready"

# Success message
echo -e "\n${GREEN}=== Installation Complete ===${NC}"
echo -e "${GREEN}✓${NC} Dotfiles have been installed successfully!"
echo -e "${GREEN}✓${NC} Oh My Zsh and Powerlevel10k configured!"
echo -e "\n${YELLOW}Next steps:${NC}"

if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo -e "  1. Restart your terminal or run: exec zsh"
    echo -e "  2. Or run: zsh"
else
    echo -e "  1. Reload your shell configuration: exec zsh"
fi

echo -e "\n${YELLOW}Your new shell includes:${NC}"
echo -e "  • Powerlevel10k theme with beautiful icons"
echo -e "  • Git, Python, and Docker plugins"
echo -e "  • PyQuant aliases and functions"
echo -e "  • All Git and Vim configurations"
echo -e "\n"
