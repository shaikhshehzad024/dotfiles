export PATH="/usr/local/bin:/usr/bin:$PATH"

if [ Darwin = `uname` ]; then
  source $HOME/.profile-macos
fi

# SSH_AUTH_SOCK set to GPG to enable using gpgagent as the ssh agent.
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


autoload -Uz compinit && compinit

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light ohmyzsh/ohmyzsh
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::rust
zinit snippet OMZP::command-not-found

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.profile
source $HOME/.config/tmuxinator/tmuxinator.zsh

if [ Linux = `uname` ]; then
  source $HOME/.profile-linux
fi

setopt auto_cd

#export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:$HOME/Library/flutter/bin"

alias sudo='sudo '
export LD_LIBRARY_PATH=/usr/local/lib

# Completions

source <(doctl completion zsh)

source <(kubectl completion zsh)

# P10k customizations
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Fix for password store
export PASSWORD_STORE_GPG_OPTS='--no-throw-keyids'

export NVM_DIR="$HOME/.nvm"                            # You can change this if you want.
export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load N

bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

[ -s "$HOME/.svm/svm.sh" ] && source "$HOME/.svm/svm.sh"

# Capslock command
alias capslock="sudo killall -USR1 caps2esc"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

zle_highlight=('paste:none')


export DESKTOP=fluxbox
alias zshconfig="$EDITOR ~/.zshrc"

export PATH=$PATH:$HOME/scripts
export BROWSER='firefox'

alias fluxmenu='$EDITOR ~/.fluxbox/menu'
alias mkcd='f() { mkdir -p "$1" && cd "$1"; }; f'
alias cls='clear'
alias rzsh='source $HOME/.zshrc'
start() {
vncserver -kill :1
vncserver :1
}
stop() {
  pkill $DESKTOP
 vncserver -kill :1
}

packages=(
  tigervnc
  fluxbox
  clang
  nodejs
  python
  wget
  curl
  fzf
  git
  neovim
  fd
  maven
)

# Empty array to collect missing packages
missing_packages=()

# Check each package
for pkgname in "${packages[@]}"; do
  if ! command -v "$pkgname" >/dev/null 2>&1; then
    missing_packages+=("$pkgname")
  fi
done

# If there are any missing packages, install them all at once
if [ "${#missing_packages[@]}" -gt 0 ]; then
  echo "Installing missing packages: ${missing_packages[*]}"
  pacman -S "${missing_packages[@]}"
  pacman -Scc
else
  echo "All packages are already installed."
fi

# Path where LazyVim starter will be installed
lazyvim_dir="${HOME}/.config/nvim"

# Check if it's already installed
if [ ! -d "$lazyvim_dir" ] || [ ! -f "${lazyvim_dir}/lazy-lock.json" ]; then
  echo "LazyVim not found. Installing lazystarter..."

  # Backup existing nvim config if any
  if [ -d "$lazyvim_dir" ]; then
    mv "$lazyvim_dir" "${lazyvim_dir}.backup.$(date +%s)"
    echo "Existing config backed up."
  fi

  # Clone the LazyVim starter template
  git clone https://github.com/LazyVim/starter "$lazyvim_dir"

  # Remove .git so it's not a Git repo
  rm -rf "${lazyvim_dir}/.git"

  echo "LazyVim starter installed successfully!"
else
  echo "LazyVim is already installed."
fi

#make the scripts file executable
chmod +x $HOME/.vnc/xstartup

