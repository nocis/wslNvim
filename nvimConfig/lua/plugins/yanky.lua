return {
	{
		"gbprod/yanky.nvim",
		keys = {
			{
				"<leader>p",
				false,
				mode = { "n", "x" },
			},
			{
				"<leader>py",
				function()
					if LazyVim.pick.picker.name == "telescope" then
						require("telescope").extensions.yank_history.yank_history({})
					elseif LazyVim.pick.picker.name == "snacks" then
						Snacks.picker.yanky()
					else
						vim.cmd([[YankyRingHistory]])
					end
				end,
				mode = { "n", "x" },
				desc = "Open Yank History",
			},
			{ "p", "<Plug>(YankyPutBefore)", mode = { "x" }, desc = "Put Text Before Cursor" },
			{ "P", "<Plug>(YankyPutAfter)", mode = { "x" }, desc = "Put Text After Cursor" },
		},
	},
}

-- plugin keymap need to explicit delete or remap!!
