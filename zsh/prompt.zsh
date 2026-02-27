# zsh/prompt.zsh - prompt styling with optional Powerlevel10k

# Load Powerlevel10k if installed
if [[ -f $DOTFILES/zsh/.p10k.zsh ]]; then
  source $DOTFILES/zsh/.p10k.zsh
else
  # Fallback prompt
  autoload -U colors && colors
  PROMPT='%F{cyan}%n@%m%f %F{yellow}%1~%f $(git_prompt_info) %# '

  git_prompt_info() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [[ -n $branch ]] && echo "%F{green}($branch)%f"
  }
fi