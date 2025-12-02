-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "<C-k>", "<Up>", { noremap = true, desc = "up" })
keymap.set("i", "<C-j>", "<Down>", { desc = "down" })
keymap.set("i", "<C-h>", "<Left>", { desc = "left" })
keymap.set("i", "<C-l>", "<Right>", { desc = "right" })
keymap.set("i", "jk", "<Esc>")
keymap.set("i", "<C-M-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })

keymap.set("n", "vv", "<C-v>", opts)
-- keymap.set("n", "<C-k>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
-- keymap.set("n", "<C-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
-- keymap.set("n", "<C-h>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
-- keymap.set("n", "<C-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })
--
-- -- Move to window using the <ctrl> hjkl keys
-- keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Go to Left Window", remap = true })
-- keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
-- keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
-- keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- inc-rename
keymap.set("n", "<leader>cr", ":IncRename ")

-- Increment/decrement
-- n: normal mode
-- keymap.set("n", "<kPlus>", function()
-- 	require("dial.map").manipulate("increment", "normal")
-- end)
-- keymap.set("n", "<kMinus>", function()
-- 	require("dial.map").manipulate("decrement", "normal")
-- end)

-- Select all bad idea
-- keymap.set("n", "<C-a>", "gg<S-v>G")

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("x", "p", "P")
keymap.set("x", "P", "p")

-- keymap.set("n", "<C-m>", "<C-i>", opts)
vim.keymap.set("n", "<leader>j", function()
	require("whatthejump").browse_jumps()
end, { desc = "show jumps" })

-- Split window
keymap.set("n", "ss", ":vsplit<Return>", opts)
keymap.set("n", "sv", ":split<Return>", opts)

-- Ctrl+D = Backspace in insert mode
keymap.set("i", "<C-d>", "<BS>", { desc = "Delete previous char" })

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
-- keymap.set("n", "<leader>p", function()
--   require("nabla").popup()
-- end, {
--   desc = "nabla popup",
-- })

-- clang type hierarchy
vim.keymap.set("n", "<leader>ct", function()
	require("clangd_extensions.type_hierarchy").show_hierarchy()
end, { desc = "clang type hierarchy" })

--
--
--
--
--
--
--
-- visual notic when capslock on

-- Create highlight group
vim.api.nvim_set_hl(0, "CapsLockLine", { bg = "#ee365f", fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "CapsLockCursor", {
	bg = "#ff0000", -- Red background
	fg = "#ffffff", -- White text
	bold = true,
})

-- Toggle state
local capslock_visual = false
local oldCursor = vim.opt.guicursor
local capslock_ns = vim.api.nvim_create_namespace("capslock_indicator")

-- Function to toggle cursor might not enough catch eyes
-- local function toggle_capslock_visual()
-- 	capslock_visual = not capslock_visual
-- 	if capslock_visual then
-- 		vim.opt.guicursor = "n-v-c:block-CapsLockCursor,i-ci-ve:ver25-CapsLockCursor"
-- 	else
-- 		vim.opt.guicursor = oldCursor
-- 	end
-- end
--

local function highlight_current_line()
	vim.api.nvim_buf_clear_namespace(0, capslock_ns, 0, -1)
	local line = vim.fn.line(".") - 1
	vim.api.nvim_buf_set_extmark(0, capslock_ns, line, 0, {
		end_row = line + 1,
		hl_group = "CapsLockLine",
		hl_eol = true,
	})
end

-- Function to detect Caps Lock state
local function check_caps_lock_xset()
	-- for wsl
	-- local handle = io.popen('powershell.exe -Command "[console]::CapsLock"')

	-- for linux
	-- local handle = io.popen('xset q | grep "Caps Lock"')

	-- local result = handle:read("*a")
	-- handle:close()
	-- return result:match("True") ~= nil

	--for linux
	-- return result:match("Caps Lock:%s+on") ~= nil

	local result = vim.fn.system('powershell.exe -NoProfile -NonInteractive -Command "[console]::CapsLock"')
	return result:match("True") ~= nil
end

local function toggle_capslock()
	capslock_visual = check_caps_lock_xset()

	if capslock_visual then
		-- Red background on current line
		highlight_current_line()
		-- switch line along with cursor
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			group = vim.api.nvim_create_augroup("CapsLockHighlight", { clear = true }),
			callback = highlight_current_line,
		})
	else
		local ok, _ = pcall(vim.api.nvim_get_autocmds, { group = "CapsLockHighlight" })
		if ok then
			vim.api.nvim_clear_autocmds({ group = "CapsLockHighlight" })
		end
		vim.api.nvim_buf_clear_namespace(0, capslock_ns, 0, -1)
	end
end

-- c-f12 = f36
-- a-f12 = f60
-- Send "!{F12}"     ; Alt+F12
-- Send "^{F12}"     ; Ctrl+F12
vim.keymap.set({ "n", "i", "v" }, "<F60><F36>", toggle_capslock)
