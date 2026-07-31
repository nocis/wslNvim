return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*", -- Latest stable release
		config = function()
			vim.g.opencode_opts = {
				server = { url = "http://localhost:64820" },
			}
		end,
		keys = {
			{
				"<leader>oa",
				function()
					require("opencode").ask("@this: ")
				end,
				mode = { "n", "x" },
				desc = "Ask OpenCode…",
			},
			{
				"<leader>oo",
				function()
					require("opencode").select()
				end,
				mode = { "n", "x" },
				desc = "Select OpenCode…",
			},
			{
				"<leader>op",
				function()
					return require("opencode").operator("@this ")
				end,
				mode = { "n", "x" },
				desc = "Append range to OpenCode",
				expr = true,
			},
			{
				"<leader>opp",
				function()
					return require("opencode").operator("@this ") .. "_"
				end,
				mode = "n",
				desc = "Append line to OpenCode",
				expr = true,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			table.insert(opts.sections.lualine_x, require("opencode").statusline)
			return opts
		end,
	},
	{
		"folke/snacks.nvim",
		opts = function(_, opts)
			-- merge input and picker settings
			opts.input = opts.input or {}
			opts.input.enabled = true -- but if already enabled, it's fine
			opts.picker = opts.picker or {}
			opts.picker.enabled = true
			opts.picker.win = opts.picker.win or {}
			opts.picker.win.input = opts.picker.win.input or {}
			opts.picker.win.input.keys = opts.picker.win.input.keys or {}
			-- add our custom key mapping
			opts.picker.win.input.keys["<a-o>"] = { "opencode_send", mode = { "n", "i" } }
			opts.picker.actions = opts.picker.actions or {}
			opts.picker.actions.opencode_send = function(picker)
				local items = vim.tbl_map(function(item)
					return item.file
							and require("opencode").format({ path = item.file, from = item.pos, to = item.end_pos })
						or item.text
				end, picker:selected({ fallback = true }))
				require("opencode").prompt(table.concat(items, ", ") .. " ")
				-- same function
			end
			return opts
		end,
	},
}
