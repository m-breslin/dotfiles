# dotfiles

Official dotfiles for the **PyQuant Platform** — modular Zsh configuration, aliases, functions, and prompt styling for devcontainers and local development.

---

## Features

- **Zsh Configuration (`.zshrc`)**  
  Central configuration that sources all modular files.

- **Aliases (`aliases.zsh`)**  
  Shortcuts for common Git, Docker, and project commands.

- **Functions (`functions.zsh`)**  
  Reusable shell functions for quick navigation, workflow automation, and development tasks.

- **Prompt Styling (`prompt.zsh`)**  
  Custom prompt with optional **Powerlevel10k** integration for Git-aware, visually rich prompts.

- **Git Configuration (`gitconfig`)**  
  Standardized Git aliases and settings.

- **Editor Configuration (`.vimrc`)** *(optional)*  
  Basic Vim setup for consistent editing experience.

---

## Quick Start

### 🐳 Using with Devcontainer (Recommended)

The dotfiles include full devcontainer support with automatic setup:

1. **Clone the repository** into your workspace:
   ```bash
   git clone https://github.com/PyQuant/dotfiles.git
   cd dotfiles
   ```

2. **Open in Devcontainer:**
   - In VS Code: Click "Reopen in Container" when prompted
   - Or use the command palette: "Dev Containers: Reopen in Container"

3. **That's it!** Everything installs automatically:
   - ✓ Zsh is installed and set as default shell
   - ✓ Oh My Zsh is installed with beautiful configuration
   - ✓ Powerlevel10k theme with icons
   - ✓ All configurations are symlinked
   - ✓ All aliases and functions are ready to use

### 🖥️ Manual Installation (Linux/macOS/WSL)

For local development or non-devcontainer environments:

**Quick Install:**
```bash
git clone https://github.com/PyQuant/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

**What the install script does:**
- Installs Zsh if not already available
- Installs Oh My Zsh with beautiful defaults
- Installs Powerlevel10k theme for gorgeous terminal icons
- Creates symlinks for all configuration files
- Sets Zsh as your default shell
- Backs up any existing configuration files

**After installation:**
```bash
exec zsh
```

### 📦 Manual Setup (Alternative)

If you prefer to set up manually:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/PyQuant/dotfiles.git ~/dotfiles
   ```

2. **Source the configuration in your `.zshrc`:**
   ```bash
   # Add this to ~/.zshrc
   export DOTFILES=~/dotfiles
   source $DOTFILES/zsh/aliases.zsh
   source $DOTFILES/zsh/functions.zsh
   source $DOTFILES/zsh/prompt.zsh
   ```

3. **For Git and Vim** (copy or symlink):
   ```bash
   # Git configuration
   cp ~/dotfiles/git/gitconfig ~/.gitconfig

   # Or symlink Vim config
   ln -s ~/dotfiles/vim/.vimrc ~/.vimrc
   ```

## Configuration

### Zsh Setup

The Zsh configuration is modular and automatically loaded from two possible locations:
- **Symlinked location** (preferred): `~/.config/zsh/`
- **Direct location**: `$DOTFILES/zsh/`

**Custom Overrides:**
Create a local configuration file to customize without editing the dotfiles:
```bash
# Option 1: Local config in home directory
echo "# Your custom aliases" > ~/.zshrc.local

# Option 2: Local config in DOTFILES directory
echo "# Your custom aliases" > ~/dotfiles/zsh/.zshrc.local
```

### Git Configuration

The Git configuration is automatically symlinked to `~/.gitconfig`. To customize:

**Edit your git user info:**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**View all Git aliases:**
```bash
git config --get-regexp alias
```

**Common Git Aliases Included:**
- `git co` → `git checkout`
- `git br` → `git branch`
- `git st` → `git status`
- `git cm` → `git commit`
- `git lg` → `git log --graph --oneline --all`

### Vim Configuration

The Vim configuration is automatically symlinked to `~/.vimrc`. The included configuration provides:
- Syntax highlighting
- Line numbers
- 2-space indentation with spaces
- Mouse support
- Cross-platform clipboard support
- Line wrapping

Edit `vim/.vimrc` in the dotfiles to customize your editor experience.

## Available Aliases & Functions

### Git Aliases
```
gs   → git status
ga   → git add
gc   → git commit
gp   → git push
gl   → git log --graph --all
```

### Docker Aliases
```
dps  → docker ps
dlogs → docker logs -f
```

### Utility Functions
```
cdp()     - Navigate to repos directory
gcp()     - Git add → commit → push (all in one)
dockin()  - Enter Docker container with Zsh shell
cls()     - Clear screen (cross-platform)
```

## Troubleshooting

### Git "Unsafe Repository" Warning

If you see a warning like:
```
fatal: detected dubious ownership in repository at '/path/to/repo'
To add an exception for this directory, call:
    git config --global --add safe.directory /path/to/repo
```

**This is resolved automatically** by the install script. Just run:
```bash
bash install.sh
```

This marks the repository as safe so you can work with it without warnings.

If you encounter this before running the install script, you can manually trust it:
```bash
git config --global --add safe.directory /path/to/dotfiles
```

### Zsh Not Set as Default Shell

**In devcontainer:**
- The devcontainer configuration automatically handles this
- If issues persist, add to `.devcontainer/devcontainer.json`:
  ```json
  "defaultProfile": "zsh"
  ```

**Manually setting the default shell:**
```bash
chsh -s $(which zsh)
```

### Configuration Not Loading

Check which DOTFILES path is being used:
```bash
zsh -c "echo $DOTFILES"
```

Verify symlinks exist:
```bash
ls -la ~/.config/zsh/
ls -la ~/.zshrc
```

Re-run the install script:
```bash
cd ~/dotfiles
bash install.sh
```

### Powerlevel10k Integration

The dotfiles come with **Powerlevel10k** installed and configured by default. It provides:

- 🎨 Beautiful terminal colors with Nerd Font icons
- 📊 Real-time git status in your prompt
- ⚡ Fast, responsive terminal experience
- 🎯 Customizable prompt segments

**You get it automatically!** Just install the dotfiles and you're ready to go.

**To customize your Powerlevel10k prompt:**
```bash
p10k configure
```

This opens an interactive wizard. For more details, see: [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)

**Note:** Install a Nerd Font for perfect icon display. Recommended: **MesloLGS NF**
- [Download Fonts](https://github.com/romkatv/powerlevel10k#fonts)
- In VS Code: Set `"terminal.integrated.fontFamily": "MesloLGS NF"` in settings

## Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Linux (devcontainer) | ✓ Full Support | Recommended setup |
| Windows (WSL/devcontainer) | ✓ Full Support | Requires WSL 2 or Git Bash |
| macOS | ✓ Full Support | Works with native Zsh |
| Git Bash (Windows) | ✓ Supported | Limited shell features |

## Development

### Running Tests

The dotfiles configuration can be tested locally:

```bash
# Test the install script
bash install.sh

# Verify all aliases
alias

# Verify all functions
compgen -c | grep -E "(cdp|gcp|dockin|cls)"
```

### Contributing

To contribute improvements to the dotfiles:

1. Create a feature branch
2. Make your changes
3. Test your changes locally and in a devcontainer
4. Submit a pull request

## License

These dotfiles are provided as-is for the PyQuant Platform.

## Support

For issues or questions:
- Check the [Troubleshooting](#troubleshooting) section
- Review the included configuration files for advanced customization
- Contact the PyQuant Platform team
