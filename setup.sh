set -e

pkg update && pkg upgrade
pkg install x11-repo
# List of packages you want
packages=(
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
  fd
  xclip
  openjdk-17
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
  pkg install -y "${missing_packages[@]}"
else
  echo "All packages are already installed."
fi

#font config

## Check if file exists
if [ -f ~/.local/share/fonts/FiraCode.zip ]; then
  echo "File already exists. Skipping download."
else
  echo "File not found. Downloading..."
  wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
fi
if [ ! -f ~/.local/share/fonts/FiraCode.zip ]; then
  echo "FiraCode.zip not found! Cannot unzip."
  exit 1
fi

unzip ~/.local/share/fonts/FiraCode.zip -d ~/.local/share/fonts
fc-cache -fv

#make the scripts file executable
chmod +x $HOME/.vnc/xstartup $HOME/scripts/*
