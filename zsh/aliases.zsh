# zsh/aliases.zsh - aliases for Git, Docker, dev workflow

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Docker shortcuts
alias dps='docker ps'
alias dlogs='docker logs -f'

# Dev navigation
alias cdp='cd $DOTFILES/../repos'  # Change to your repos folder

# OS-specific aliases
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
fi