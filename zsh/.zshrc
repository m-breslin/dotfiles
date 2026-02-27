# zsh/.zshrc - main entry for PyQuant Platform

# Detect OS
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
  # Windows Git Bash
  export DOTFILES="/c/development/dotfiles"
else
  # Linux or Mac
  export DOTFILES="$HOME/dotfiles"
fi

# Source modular files
[[ -f $DOTFILES/zsh/aliases.zsh ]] && source $DOTFILES/zsh/aliases.zsh
[[ -f $DOTFILES/zsh/functions.zsh ]] && source $DOTFILES/zsh/functions.zsh
[[ -f $DOTFILES/zsh/prompt.zsh ]] && source $DOTFILES/zsh/prompt.zsh
[[ -f $DOTFILES/zsh/.zshrc.local ]] && source $DOTFILES/zsh/.zshrc.local