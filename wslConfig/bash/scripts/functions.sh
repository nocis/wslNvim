# -------------------------------------
#
# User functions
#
# -------------------------------------

project() {
    pjlist=$(find ~/Projects/ -name '.*' -prune -name '.git' -printf "%h\n" | fzf --height=10%)
    echo $pjlist
    cd $pjlist
}

connectX11Bus() {
    echo "enter the sudo password, please"
    read -s PW
    echo $PW | sudo -kS service dbus start >/dev/null 2>&1
    export XDG_RUNTIME_DIR=/run/user/$(id -u)
    echo $PW | sudo -kS mkdir -p $XDG_RUNTIME_USER >/dev/null 2>&1
    echo $PW | sudo -kS chmod 700 $XDG_RUNTIME_DIR >/dev/null 2>&1
    echo $PW | sudo -kS chown $(id -un):$(id -gn) $XDG_RUNTIME_DIR >/dev/null 2>&1
    export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
    dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &
}

purgenvim() {
    rm -rf ~/.local/state/nvim/ ~/.config/nvim/ ~/.local/share/nvim/ ~/.cache/nvim
}

purgeswp() {
    rm ~/.local/state/nvim/swap/*.swp
    rm ~/.local/state/nvim/swap/*.swo
}

confignvim() {
    rm -rf ~/.config/nvim/lua/config ~/.config/nvim/lua/plugins ~/.config/nvim/snippets
    ln -s ~/.config/wslNvim/{config,plugins} ~/.config/nvim/lua/
    ln -s ~/.config/wslNvim/snippets ~/.config/nvim/
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Function to open yazi, pick a file, and print the path
function yp() {
    local tmp="$(mktemp -t "yazi-chooser.XXXXXX")"
    yazi "$@" --chooser-file="$tmp"
    if [ -f "$tmp" ]; then
        cat "$tmp"
        rm -f "$tmp"
    fi
}
