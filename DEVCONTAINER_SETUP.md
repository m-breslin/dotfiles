# Devcontainer Setup Guide

This guide covers setting up the PyQuant dotfiles in a devcontainer environment.

## Quick Start

### Option 1: Use the Included Devcontainer Configuration

If you want to use the pre-configured devcontainer setup:

1. **Open the workspace in VS Code**
2. **Click the "Reopen in Container" prompt** or use the command palette
3. **Wait for the container to build and setup**

That's it! The setup runs automatically via the `postCreateCommand` hook.

### Option 2: Add to Your Existing Devcontainer Project

To integrate these dotfiles into an existing devcontainer project:

1. **Copy the `.devcontainer` folder** from this repo to your project
2. **Update your `.devcontainer/devcontainer.json`** to reference your dotfiles location:
   ```json
   {
     "postCreateCommand": "bash /path/to/dotfiles/.devcontainer/post-create.sh"
   }
   ```

3. **Rebuild the devcontainer** when you restart

## What Gets Installed

When the devcontainer setup runs:

✓ **Zsh shell** is installed (if not already present)
✓ **Shell configuration** is symlinked to `~/.config/zsh/`
✓ **Git configuration** is set up globally
✓ **Vim configuration** is configured
✓ **All aliases and functions** are available
✓ **Default shell** is set to Zsh
✓ **Welcome message** is displayed on startup

## Customizing Your Devcontainer

### Adding VS Code Extensions

Edit `.devcontainer/devcontainer.json`:

```json
"customizations": {
  "vscode": {
    "extensions": [
      "ms-vscode.makefile-tools",
      "vim.vim",
      "YOUR_EXTENSION_ID_HERE"
    ]
  }
}
```

### Adding System Packages

Modify `.devcontainer/devcontainer.json`:

```json
"features": {
  "ghcr.io/devcontainers/features/git:1": {},
  "ghcr.io/devcontainers/features/docker-in-docker:2": {}
}
```

Or create a `Dockerfile` in `.devcontainer/`:

```dockerfile
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

RUN apt-get update && apt-get install -y \
    your-package-name \
    another-package \
    && rm -rf /var/lib/apt/lists/*
```

### Port Forwarding

To expose ports from the container, modify `.devcontainer/devcontainer.json`:

```json
"forwardPorts": [3000, 5000, 8000]
```

### Environment Variables

Set environment variables in `.devcontainer/devcontainer.json`:

```json
"containerEnv": {
  "NODE_ENV": "development",
  "CUSTOM_VAR": "value"
}
```

## Troubleshooting

### Zsh Not Available After Rebuild

The setup script automatically installs Zsh, but if it's missing:

```bash
sudo apt-get update && sudo apt-get install -y zsh
```

Then rebuild the devcontainer.

### Configuration Not Loading

Check that symlinks were created:

```bash
ls -la ~/.config/zsh/
ls -la ~/.zshrc
```

Run the install script manually:

```bash
bash /workspaces/dotfiles/install.sh
```

### Welcome Message Not Showing

The welcome message should appear on new shell sessions. If not:

```bash
source ~/.welcome.sh
```

Or check that it's properly sourced in `.zshrc`:

```bash
grep "welcome.sh" ~/.zshrc
```

### Permission Denied on install.sh

The post-create script automatically makes `install.sh` executable, but if you're running it manually:

```bash
chmod +x /workspaces/dotfiles/install.sh
```

## File Structure

```
.devcontainer/
├── devcontainer.json      # Main devcontainer configuration
└── post-create.sh         # Runs automatically on devcontainer creation

install.sh                  # Manual installation script
```

## Platform-Specific Notes

### Linux Devcontainers

- Full support for all shell features
- All aliases and functions work natively
- No additional configuration needed

### Windows with WSL 2

**If using WSL 2 in devcontainer:**
- The dotfiles work exactly like Linux
- No special configuration needed
- Paths use Unix-style (`/home/user` not `C:\Users\user`)

### macOS Devcontainers

- All features work natively
- Native Zsh version may differ from Linux version in container
- Container runs on the version specified in `image` field

## Performance Tips

1. **First build may take a few minutes** (installing Zsh, creating symlinks)
2. **Subsequent rebuilds are faster** (cached layers)
3. **Mount volumes efficiently** to avoid slowness
4. **Use `.devcontainerignore`** to exclude files from context

## Advanced Customization

### Running Custom Setup Script

Create `.devcontainer/setup.sh`:

```bash
#!/usr/bin/env bash
set -e

# Your custom setup here
echo "Running custom setup..."

# Then run the dotfiles setup
bash /workspaces/dotfiles/install.sh
```

Update `devcontainer.json`:

```json
"postCreateCommand": "bash .devcontainer/setup.sh"
```

### Using a Custom Base Image

Replace the image in `devcontainer.json`:

```json
"image": "mcr.microsoft.com/devcontainers/python:3.11"
```

Available images: https://hub.docker.com/r/microsoft/devcontainers/tags

### Environment-Specific Configuration

Create multiple devcontainer configs:
- `.devcontainer/devcontainer.json` (default)
- `.devcontainer/python.json` (for Python projects)
- `.devcontainer/node.json` (for Node projects)

Switch with: `Dev Containers: Reopen in Container` command

## See Also

- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Dev Container Spec](https://containers.dev/)
- [Main README](../README.md)
