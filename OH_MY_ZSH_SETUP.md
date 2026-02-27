# Oh My Zsh Integration Guide

The PyQuant dotfiles are designed to work seamlessly with **Oh My Zsh** for an enhanced terminal experience.

## Quick Setup

### Step 1: Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

The PyQuant `.zshrc` will automatically detect Oh My Zsh and load it if available.

### Step 2: (Optional) Install Powerlevel10k Theme

For beautiful terminal icons and colors like in the welcome message:

```bash
# Clone Powerlevel10k into Oh My Zsh themes
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# The PyQuant .zshrc will auto-detect and use it
# Run the configuration wizard:
p10k configure
```

### Step 3: Install Required Fonts (Optional but Recommended)

Powerlevel10k looks best with special fonts. Download and install:

**Option A: Using Git**
```bash
git clone https://github.com/romkatv/powerlevel10k-media.git ~/Downloads/powerlevel10k-media
# Install any `.otf` or `.ttf` fonts from the folder
```

**Option B: Direct Download**
- Visit: https://github.com/romkatv/powerlevel10k#fonts
- Download your preferred font
- Install on your system

**In VS Code:**
```json
{
  "terminal.integrated.fontFamily": "MesloLGS NF"
}
```

## What Gets Loaded

When Oh My Zsh is installed, the PyQuant `.zshrc` automatically:

✓ Sets Powerlevel10k as the theme (if installed)
✓ Enables git, python, and docker plugins
✓ Loads all PyQuant aliases and functions
✓ Integrates with your `.p10k.zsh` configuration

## Features Enabled by Oh My Zsh

| Feature | Purpose |
|---------|---------|
| **git plugin** | Enhanced git command completion and info |
| **python plugin** | Python command completion and virtualenv support |
| **docker plugin** | Docker command completion |
| **Powerlevel10k** | Beautiful, fast terminal prompt with git status |

## Without Oh My Zsh

If you don't install Oh My Zsh, the dotfiles still work perfectly:
- All aliases work
- All functions work
- Custom prompt displays (less fancy, but functional)
- Fallback to zsh defaults

## Customizing Plugins

To add more plugins, edit your `.zshrc.local`:

```bash
# Override plugins in ~/.zshrc.local
plugins=(git python docker nvm node npm history)
```

Then reload:
```bash
exec zsh
```

## Configuring Powerlevel10k

Once installed, customize your prompt:

```bash
# Interactive configuration
p10k configure

# Or manually edit
vim/$HOME/.p10k.zsh
```

Popular configurations:
- **Left prompt**: Shows username, directory, git branch
- **Right prompt**: Shows command status, time, Python version
- **Separators**: Different styles (round, sharp, slanted)

## Troubleshooting

### Powerlevel10k Not Loading

Check if it's installed:
```bash
ls $ZSH/custom/themes/powerlevel10k
```

If missing, install it:
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Fonts Show Wrong Characters

You need to install Nerd Fonts:

**macOS:**
```bash
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
```

**Linux:**
```bash
# Download and install manually, or use your package manager
sudo apt install fonts-powerline  # Debian/Ubuntu
```

**Windows:**
- Download from https://github.com/romkatv/powerlevel10k#fonts
- Right-click → Install on each `.ttf` file

Then update your terminal font settings.

### Performance Issues

If the prompt feels slow:

1. **Check git operations:**
   ```bash
   p10k configure
   ```
   Disable git status if in large repos

2. **Disable unused plugins in `.zshrc.local`:**
   ```bash
   plugins=(git)  # Keep only what you need
   ```

3. **Use instant prompt:**
   ```bash
   POWERLEVEL10K_INSTANT_PROMPT=off  # Or =verbose to debug
   ```

## See Also

- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Powerlevel10k Documentation](https://github.com/romkatv/powerlevel10k)
- [PyQuant Dotfiles README](./README.md)
- [Main Configuration Guide](./DEVCONTAINER_SETUP.md)
