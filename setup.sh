pkg update && pkg upgrade
pkg install x11-repo
pkg install tigervnc fluxbox clang nodejs python git neovim

chmod +x $HOME/.vnc/xstartup $HOME/scripts/*
