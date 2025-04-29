pkg update && pkg upgrade

# List of packages you want
packages=(
    x11-repo
    tigervnc
    fluxbox
    clang
    nodejs
    python
    wget
    zsh
    curl
    fzf
    git
    fontconfig
    neovim

)

# Empty array to collect missing packages
missing_packages=()

# Check each package
for pkgname in "${packages[@]}"; do
    if ! command -v "$pkgname" > /dev/null 2>&1; then
        missing_packages+=("$pkgname")
    fi
done

# If there are any missing packages, install them all at once
if [ "${#missing_packages[@]}" -gt 0 ]; then
    echo "Installing missing packages: ${missing_packages[*]}"
    pkg install -y "${missing_packages[@]}"
else
    echo "All packages are already installed."
fi

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

pkg install neovim git fd python clang nodejs xclipg
git clone https://github.com/LazyVim/starter ~/.config/nvim

echo "indent_type = \"Spaces\"
indent_width = 4
column_width = 120" > ~/.config/nvim/stylua.toml
