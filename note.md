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
pyenv install xx

7. apps and configs
nvim
hyper
starship

8. deps
sudo apt install build-essential libfuse2 unzip 


