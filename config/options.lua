-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.laststatus = 2 -- always: show for every window
vim.opt.completeopt = "menu,menuone,preview,noinsert,noselect"

vim.o.expandtab = true -- "Use softtabstop spaces instead of tab characters for indentation
vim.o.shiftwidth = 4 -- "Indent by 4 spaces when using >>, <<, == etc.
vim.o.softtabstop = 4 -- "Indent by 4 spaces when pressing <TAB>

vim.g.lazyvim_python_lsp = "basedpyright"

-- **************
-- pynotebook
-- **************

-- I find auto open annoying, keep in mind setting this option will require setting
-- a keybind for `:noautocmd MoltenEnterOutput` to open the output again
vim.g.molten_auto_open_output = false

-- optional, I like wrapping. works for virt text and the output window
vim.g.molten_wrap_output = true

-- Output as virtual text. Allows outputs to always be shown, works with images, but can
-- be buggy with longer images
vim.g.molten_virt_text_output = true

-- this will make it so the output shows up below the \`\`\` cell delimiter
vim.g.molten_virt_lines_off_by_1 = true

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")
