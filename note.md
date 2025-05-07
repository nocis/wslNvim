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
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
xorg-dev cmake

pyenv install xx

7. apps and configs
nvim
hyper
starship


9. deps
sudo apt install build-essential libfuse2 libasound2t64 unzip ripgrep fd-find wl-clipboard

10. wayland wsl socket:

❯ cat ~/.config/systemd/user/symlink-wayland-socket.service
[Unit]
Description=Symlink Wayland socket to XDG_RUNTIME_DIR

[Service]
Type=oneshot
ExecStart=/usr/bin/ln -s /mnt/wslg/runtime-dir/wayland-0      $XDG_RUNTIME_DIR
ExecStart=/usr/bin/ln -s /mnt/wslg/runtime-dir/wayland-0.lock $XDG_RUNTIME_DIR

[Install]
WantedBy=default.target


Enable it using the following command.
systemctl --user enable symlink-wayland-socket.service


11. treesitter cli
npm install -g tree-sitter-cli


12. chrome
Change directories into the temp folder: cd /tmp
Use wget to download it: wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
Install the package: sudo apt install --fix-missing ./google-chrome-stable_current_amd64.deb

13. pynotebook
create neovim python env
python -m venv ~/.virtualenvs/neovim
source ~/.virtualenvs/neovim/bin/activate
pip install pynvim jupyter_client cairosvg plotly kaleido pnglatex pyperclip quarto-cli 

install kernel for project:
python -m venv project_name
source project_name/bin/activate 
pip install ipykernel
python -m ipykernel install --user --name project_name
MoltenInit project_name # start the kernel

14. WSL-Ubuntu CUDA toolkit 
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.8.1/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-8-local_12.8.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8

15. integrate desktop docker into wsl2
download docker desktop
enable wsl2 backend
integrate docker into wsl2

16. NVIDIA  Container Toolkit(use gpu inside docker container)
make sure driver on win, coda tookit on wsl, are installed
install NVIDIA Container Toolkit
Configuring Docker

17. docker run
docker run -it -p 8888:8888 -u 1000:1000 -v $(pwd):/tf/notebooks --gpus all tensorflow/tensorflow:latest-jupyter bash
jupyter server (--allow-root, for docker without -u) --ip 0.0.0.0 --port 8888


18. host dev env
pyenv install [dockerpyver]
pyenv local [dockerpyver]

pyenv exec python -m venv [dockerMatchedEnv]
source [dockerMatchedEnv]/bin/activate

pip install jupytext ...(tensorflow,numpy,...)
deactivate

20. molten
source ~/.virtualenvs/neovim/bin/activate
pip install requests websocket websocket-client
deactivate

:MoltenInit http://localhost:8888?token=xx


