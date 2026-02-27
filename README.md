# dotfiles

Professional dotfiles for Python development → modular Zsh configuration, aliases, functions, and prompt styling for devcontainers and local development.

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
   git clone <your-repo-url> dotfiles
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

## Configuration

### Zsh Setup

The Zsh configuration is modular and automatically loaded from two possible locations:
- **Symlinked location** (preferred): `~/.config/zsh/`
- **Direct location**: `$DOTFILES/zsh/`

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
