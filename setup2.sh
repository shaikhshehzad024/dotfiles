
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
