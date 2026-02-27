# zsh/functions.zsh - reusable shell functions

# Navigate to a repo folder
function cdp() {
  local target="$DOTFILES/../repos/$1"
  if [[ -d $target ]]; then
    cd $target
  else
    echo "Repo $1 not found at $target"
  fi
}

# Git add, commit, push in one step
function gcp() {
  git add .
  git commit -m "$1"
  git push
}

# Enter Docker container
function dockin() {
  docker exec -it "$1" /bin/zsh
}

# Clear screen (Windows vs Linux/Mac)
if [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "win32" ]]; then
  function cls() { clear; }  # Git Bash can use clear for simplicity
else
  function cls() { clear; }
fi