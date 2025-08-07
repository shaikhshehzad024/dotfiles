pkg update && pkg upgrade

# List of packages you want
packages=(
  clang
  python
  wget
  fzf
  git
  fd
  ripgreep
  xclip
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
