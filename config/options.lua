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

vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
})
