# -------------------------------------------------
# 🎯 PyQuant Platform - Zsh Configuration
# -------------------------------------------------

# -------------------------------------------------
# 🌀 Oh My Zsh - The Default Shell Experience
# -------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Theme: Powerlevel10k for beautiful terminal
ZSH_THEME="powerlevel10k/powerlevel10k"

# Core plugins (light but useful)
plugins=(git python docker)

# Load Oh My Zsh
[[ -s "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# -------------------------------------------------
# 📍 Detect OS and Set DOTFILES Path
# -------------------------------------------------
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
  # Windows Git Bash
  export DOTFILES="${DOTFILES:-/c/development/dotfiles}"
else
  # Linux, macOS, or devcontainer
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

# -------------------------------------------------
# 🧰 Environment and Path
# -------------------------------------------------
export EDITOR="${EDITOR:-vim}"
export PAGER="${PAGER:-less}"
export TERM="xterm-256color"
export PATH="$HOME/.local/bin:$PATH"

# -------------------------------------------------
# 📜 History Configuration
# -------------------------------------------------
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# -------------------------------------------------
# 🔧 PyQuant Dotfiles - Load Modular Configuration
# -------------------------------------------------
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

# -------------------------------------------------
# 🎨 Powerlevel10k Configuration
# -------------------------------------------------
# Load Powerlevel10k config if available (creates instant prompt)
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# -------------------------------------------------
# 📋 Load Local Customizations
# -------------------------------------------------
# Source local overrides if they exist (user-specific, not committed)
for local_config in "$DOTFILES/zsh/.zshrc.local" "$HOME/.zshrc.local"; do
  [[ -f "$local_config" ]] && source "$local_config"
done

# -------------------------------------------------
# 💬 Welcome Message (Interactive Shells Only)
# -------------------------------------------------
if [[ $- == *i* ]]; then
  printf "\n"
  printf "  ∞ Welcome to PyQuant Dev Environment ∞\n"

  # Detect environment
  if [[ -f "/.dockerenv" ]]; then
    printf "  🐳 Devcontainer  |  "
  else
    printf "  💻 Local  |  "
  fi

  # Show shell and zsh version
  printf "⚡ Zsh %s\n" "$ZSH_VERSION"

  # Show available commands tip
  printf "\n  💡 Tip: Type 'alias' to see all shortcuts\n"
  printf "\n"
fi