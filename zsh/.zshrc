# zsh/.zshrc - main entry for PyQuant Platform

# Detect OS and set DOTFILES path
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
  # Windows Git Bash
  export DOTFILES="${DOTFILES:-/c/development/dotfiles}"
else
  # Linux, macOS, or devcontainer
  # Try environment variable first, then home directory, then /workspaces/dotfiles (devcontainer)
  if [[ -n "$DOTFILES_REPO" ]]; then
    export DOTFILES="$DOTFILES_REPO"
  else
    export DOTFILES="${HOME}/dotfiles"
    # Check for devcontainer location
    if [[ ! -d "$DOTFILES" ]] && [[ -d "/workspaces/dotfiles" ]]; then
      export DOTFILES="/workspaces/dotfiles"
    fi
  fi
fi

# Source modular files from multiple possible locations
# First try symlinked location in ~/.config/zsh
# Then fall back to original location in DOTFILES
for config_file in aliases functions prompt; do
  if [[ -f "$HOME/.config/zsh/${config_file}.zsh" ]]; then
    source "$HOME/.config/zsh/${config_file}.zsh"
  elif [[ -f "$DOTFILES/zsh/${config_file}.zsh" ]]; then
    source "$DOTFILES/zsh/${config_file}.zsh"
  fi
done

# Source local overrides if they exist
for local_config in "$DOTFILES/zsh/.zshrc.local" "$HOME/.zshrc.local"; do
  [[ -f "$local_config" ]] && source "$local_config"
done