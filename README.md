# wsl port exposure
1. add port to firewall inbound rule( enable other machine access via ip:port )
2. listening the port and forwarding to wsl ip:port (netsh interface portproxy)
   ie. netsh interface portproxy add v4tov4 listenport=8001 listenaddress=192.168.0.10 connectport=80 connectaddress=192.168.0.10

# wslNvim


# winterm conmand_prompts not working
make sure open with the C:\Windows\system32\wsl.exe -d Ubuntu instead of ubuntu.exe

# x11 does not support Electron gpu, so run it on windows please!
# fix dbus error(chrome,hyper) when on wsl2
# also need to install upower
connectX11Bus(){
echo "enter the sudo password, please"
read -s PW
echo $PW | sudo -kS service dbus start > /dev/null 2>&1
export XDG_RUNTIME_DIR=/run/user/$(id -u)
echo $PW | sudo -kS mkdir -p $XDG_RUNTIME_USER > /dev/null 2>&1
echo $PW | sudo -kS chmod 700 $XDG_RUNTIME_DIR > /dev/null 2>&1
echo $PW | sudo -kS chown $(id -un):$(id -gn) $XDG_RUNTIME_DIR > /dev/null 2>&1
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &
}

# Hyper use ~/.config/Hyper/hyper.json to config


# keymapping
cap -> ctrl
win -> cap
ctrl -> ctrl+alt

esc -> :
cap+[ -> esc
win+dir -> dir

