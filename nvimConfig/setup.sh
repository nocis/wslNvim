#!/bin/bash

# Get the absolute path of the directory where this script is located
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TARGET_DIR="$HOME/.config/nvim"

echo "Setting up Neovim symlinks from: $SOURCE_DIR"

# 1. Create the necessary parent directories in ~/.config/nvim
# We need to make sure the 'lua' folder exists before linking into it
mkdir -p "$TARGET_DIR/lua"

# Function to create a symlink with backup capability
link_file() {
    local src=$1
    local dest=$2

    # Check if the source actually exists
    if [ ! -e "$src" ]; then
        echo "⚠️  Warning: Source '$src' does not exist. Skipping."
        return
    fi

    # Check if destination exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        # If it is already a symbolic link, remove it so we can update it
        if [ -L "$dest" ]; then
            rm "$dest"
        # If it is a real directory/file, back it up
        else
            echo "backing up existing $dest to $dest.bak"
            mv "$dest" "$dest.bak"
        fi
    fi

    # Create the symbolic link
    ln -s "$src" "$dest"
    echo "✅ Linked: $src -> $dest"
}

# --- Create the specific links ---

# 1. lua/config
link_file "$SOURCE_DIR/lua/config" "$TARGET_DIR/lua/config"

# 2. lua/plugins
link_file "$SOURCE_DIR/lua/plugins" "$TARGET_DIR/lua/plugins"

# 3. snippits
link_file "$SOURCE_DIR/snippets" "$TARGET_DIR/snippets"

echo "Done!"
