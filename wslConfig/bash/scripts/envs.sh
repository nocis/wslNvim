# -------------------------------------
#
# User envs
#
# -------------------------------------
#
export PATH="$PATH:/opt/nvim/"
export PATH="$PATH:/opt/hyper/"
export PATH="$PATH:/opt/magick/"
export PATH="$PATH:/opt/lazygit/"
export PATH="$PATH:/opt/lazydocker/"
export PATH="$PATH:/opt/yazi/"
export PATH="$PATH:~/.local/bin/"
# lazygit lazydocker yazi all these three dont respect starship color

export COLORTERM=truecolor
# WSL/Terminal integration (Window Title / Current Dir)
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'
# PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "%s" "$PWD"'

# <c-x> <c-e> to edit and run prompt via nvim
export EDITOR=nvim

# c-d 5 times to exit shell
export IGNOREEOF=4
