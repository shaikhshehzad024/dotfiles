export $EDITOR=nvim
export PATH:$PATH:/scripts
export BROWSER="firefox"

alias fluxmenu="$EDITOR ~/.fluxbox/menu"
alias mkcd='f() { mkdir -p "$1" && cd "$1"; }; f'

editshrc(){
if [ "$SHELL" == "/bin/bash" ]; then
    $EDITOR ~/.bashrc
  elif [ "$SHELL" == "/bin/zsh" ]; then
    $EDITOR ~/.zshrc
  else
    echo "Unsupported shell: $SHELL"
  fi
}
