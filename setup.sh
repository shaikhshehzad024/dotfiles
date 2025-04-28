pkg update && pkg upgrade
pkg install x11-repo
pkg install tigervnc fluxbox clang nodejs python wget zsh curl fzf git fontconfig neovim

#font config
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
unzip ~/.local/share/fonts/FiraCode.zip -d ~/.local/share/fonts
fc-cache -fv

#installing oh-my-zsh and appending the previous .zshrc in the new .zshrc file
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

PRE_OHMYZSH_FILE="$HOME/.zshrc.pre-oh-my-zsh"
ZSHRC_FILE="$HOME/.zshrc"

# Check if the backup file exists
if [ -f "$PRE_OHMYZSH_FILE" ]; then
    echo "Appending contents of $PRE_OHMYZSH_FILE to $ZSHRC_FILE"

    # Append the contents of the pre-oh-my-zsh backup to the new .zshrc file
    cat "$PRE_OHMYZSH_FILE" >> "$ZSHRC_FILE"

    echo "Contents appended successfully!"
else
    echo "Error: $PRE_OHMYZSH_FILE not found. Make sure the file exists."
fi

#make the scripts file executable
chmod +x $HOME/.vnc/xstartup $HOME/scripts/*
