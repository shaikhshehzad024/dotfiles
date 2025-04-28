pkg update && pkg upgrade
pkg install x11-repo
pkg install tigervnc fluxbox clang nodejs python wget zsh curl fzf git neovim
chmod +x $HOME/.vnc/xstartup $HOME/scripts/*

chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
