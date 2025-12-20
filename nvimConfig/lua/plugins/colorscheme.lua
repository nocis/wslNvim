return {
	{
		"folke/tokyonight.nvim",
		opts = {
			style = "storm",
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_highlights = function(highlights, colors)
				highlights.FlashLabel = {
					bg = "#ff007c",
					fg = "#19486c",
					bold = false,
				}
				--highlights.NeoTreeDimText = {
				-- fg = "#ffffff",
				--}
				--highlights.NeoTreeWindowsHidden = {
				-- fg = "#ffffff",
				--}
				--highlights.NeoTreeDotfile = {
				-- fg = "#ffffff",
				--}
				highlights.NeoTreeMessage = {
					fg = "#777777",
				}
				highlights.DiagnosticUnnecessary = {
					fg = "#777777",
				}
				highlights.MatchParen = {
					bg = "#ff9e64",
					fg = "#140000",
				}
				highlights.Comment = {
					fg = "#656995",
					italic = true,
				}
				highlights.LineNr = {
					fg = "#7076b0",
				}
				highlights.CursorLineNr = {
					fg = "#facb39",
					bold = true,
				}
				highlights.LspReferenceRead = {
					bg = "#3b4a78",
					underline = true,
				}
				highlights.LspReferenceText = {
					bg = "#3b4a78",
					underline = true,
				}
				highlights.LspReferenceWrite = {
					bg = "#3b4a78",
					underline = true,
				}
				highlights.Visual = {
					bg = "#394785",
				}
			end,
		},
	},
	-- snacks Automatically configures lazygit with a theme generated based on your Neovim colorscheme
	-- this broken the activeborder color
	-- activeBorderColor = { fg = "MatchParen", bold = true }
	-- this broken because it is not using fg and using bg instead
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			lazygit = {
				configure = true,
				theme = {
					[241] = { fg = "Special" },
					activeBorderColor = { bg = "MatchParen", bold = true },
					cherryPickedCommitBgColor = { fg = "Identifier" },
					cherryPickedCommitFgColor = { fg = "Function" },
					defaultFgColor = { fg = "Normal" },
					inactiveBorderColor = { fg = "FloatBorder" },
					optionsTextColor = { fg = "Function" },
					searchingActiveBorderColor = { bg = "MatchParen", bold = true },
					selectedLineBgColor = { bg = "Visual" },
					unstagedChangesColor = { fg = "DiagnosticError" },
				},
			},
		},
	},
}

-- #facb39
-- #565f89
-- #a9b1d6
-- #c0caf5
-- #ff9e64
-- #3b4261
-- #364A82
-- #1f2335

-- lazygit default border will send gocui.ColorDefault by default
--
-- vim.g.terminal_color_0 through 15: These map to specific ANSI color codes (0–15).
-- gocui.ColorDefault: This sends an ANSI "Reset" code (usually \x1b[39m for foreground or \x1b[49m for background).
-- aka Normal
--
-- lazygit is almost certainly running in a floating window.
--
-- While looking at lazygit, press: <C-\><C-n>
-- Your cursor will change to a normal cursor in neovim no lazygit,
-- :echo &winhighlight Neovim use winhighlight as float terminal color group
--
-- which shows us Normal:SnacksNormal
--
-- But there is no SnacksNormal defined neither tokyonight nor snacks
-- even :verbose hi not show this SnacksNormal
-- Normal:SnacksNormal,NormalNC:SnacksNormalNC,WinBar:SnacksWinBar,WinBarNC:SnacksWinBarNC,FloatTitle:SnacksTitle,FloatFooter:SnacksFooter,WinSeparator:SnacksWinSeparator
--
-- try to add SnacksNormal highlight found lazygit is not using it!!!
--
-- after massive try find out the inactiveborder -> gocui.ColorDefault -> is FloatBorder!!!!
--
-- SHOW ALL TERMINAL COLOR
-- lua for i=0,15 do print(string.format("terminal_color_%d: %s", i, vim.g["terminal_color_"..i] or "N/A")) end
--
--
-- we noticed that set vim.g.terminal_color_* not affect what inside floatterm
