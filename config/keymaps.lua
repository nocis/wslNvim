-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "vv", "<C-v>", opts)
keymap.set("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
keymap.set("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
keymap.set("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
keymap.set("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- inc-rename
keymap.set("n", "<leader>cr", ":IncRename ")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')

-- keymap.set("n", "<C-m>", "<C-i>", opts)
vim.keymap.set("n", "<leader>j", function()
  require("whatthejump").browse_jumps()
end, { desc = "show jumps" })

-- Split window
keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)

-- Diagnostics
vim.keymap.set("n", "<leader>i", function()
  -- If we find a floating window, close it.
  local found_float = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
      found_float = true
    end
  end

  if found_float then
    return
  end

  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end, { desc = "Toggle Diagnostics" })

-- nabla
keymap.set("n", "<leader>p", function()
  require("nabla").popup()
end, {
  desc = "nabla popup",
})

-- clang type hierarchy
vim.keymap.set("n", "<leader>ct", function()
  require("clangd_extensions.type_hierarchy").show_hierarchy()
end, { desc = "clang type hierarchy" })
