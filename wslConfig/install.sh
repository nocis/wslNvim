#!/bin/bash

# 1. Get the absolute path of the directory where this install.sh script is located
#    This ensures the script works even if called from a different directory.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📂 Dotfiles directory detected at: $DOTFILES_DIR"

# ---------------------------------------------------------
# TASK 1: Call bash/init.sh
# ---------------------------------------------------------
BASH_INIT="$DOTFILES_DIR/bash/init.sh"

if [ -f "$BASH_INIT" ]; then
    echo "🚀 Executing bash setup..."

    # Make it executable just in case
    chmod +x "$BASH_INIT"

    # Execute the script
    bash "$BASH_INIT"

    echo "✅ Bash setup complete."
else
    echo "⚠️  Warning: $BASH_INIT not found, skipping."
fi

# ---------------------------------------------------------
# TASK 2: Symlinks
# ---------------------------------------------------------
YAZI_SOURCE="$DOTFILES_DIR/yazi/"
YAZI_TARGET="$HOME/.config"

PWNDBG_SOURCE="$DOTFILES_DIR/pwndbg/.gdbinit"
PWNDBG_TARGET="$HOME/.gdbinit"

INPUTRC_SOURCE="$DOTFILES_DIR/inputrc/.inputrc"
INPUTRC_TARGET="$HOME/.inputrc"

TMUX_SOURCE="$DOTFILES_DIR/tmux/.tmux.conf"
TMUX_TARGET="$HOME/.tmux.conf"

echo "🔗 Linking Yazi configuration..."

# Check if source exists
if [ -d "$YAZI_SOURCE" ]; then
    # Ensure ~/.config exists
    mkdir -p "$HOME/.config"
    ln -sf -t "$YAZI_TARGET" "$YAZI_SOURCE"
    echo "✅ Linked $YAZI_SOURCE -> $YAZI_TARGET"
else
    echo "⚠️  Warning: Source directory $YAZI_SOURCE does not exist. Skipping link."
fi

echo "🔗 Linking pwdgdb configuration..."

# Check if source exists
if [ -f "$PWNDBG_SOURCE" ]; then
    ln -sf "$PWNDBG_SOURCE" "$PWNDBG_TARGET"
    echo "✅ Linked $PWNDBG_SOURCE -> $PWNDBG_TARGET"
else
    echo "⚠️  Warning: Source $PWNDBG_SOURCE does not exist. Skipping link."
fi

echo "🔗 Linking .inputrc configuration..."

# Check if source exists
if [ -f "$INPUTRC_SOURCE" ]; then
    ln -sf "$INPUTRC_SOURCE" "$INPUTRC_TARGET"
    echo "✅ Linked $INPUTRC_SOURCE -> $INPUTRC_TARGET"
else
    echo "⚠️  Warning: Source $PWNDBG_SOURCE does not exist. Skipping link."
fi

echo "🔗 Linking .tmux.conf configuration..."

# Check if source exists
if [ -f "$TMUX_SOURCE" ]; then
    ln -sf "$TMUX_SOURCE" "$TMUX_TARGET"
    echo "✅ Linked $TMUX_SOURCE -> $TMUX_TARGET"
else
    echo "⚠️  Warning: Source $TMUX_SOURCE does not exist. Skipping link."
fi

echo "🎉 Installation finished!"
