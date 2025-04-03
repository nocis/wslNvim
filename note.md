1. install
wsl.exe --install // install linux kernel

wsl --set-default-version 2
wsl --update
wsl --install -d Ubuntu


2. update
sudo apt update && sudo apt upgrade

3. git
sudo apt-get install git
git config --global user.name "Your Name"
git config --global user.email "youremail@domain.com"
ssh-keygen -t ed25519 -C "your_email@example.com"

4. winterm
fonts: 0XProto mono
add a new ubuntu profile, set starting dir: ~

5. envs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
nvm install xx

curl -fsSL https://pyenv.run | bash

sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

pyenv install xx

7. apps and configs
nvim
hyper
starship


9. deps
sudo apt install build-essential libfuse2 unzip ripgrep fd-find wl-clipboard


