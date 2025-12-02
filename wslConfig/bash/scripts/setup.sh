# -------------------------------------
#
# User post setup
#
# -------------------------------------

# 1. Initialize Starship (Must be last to capture all envs)
if command -v starship 1>/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
