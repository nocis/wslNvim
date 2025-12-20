return {
	{
		"tomasky/bookmarks.nvim",
		lazy = true,
		keys = {
			{
				"<leader>ma",
				function()
					require("bookmarks").bookmark_toggle()
				end,
				desc = "Toggle mark",
			},
			{
				"<leader>me",
				function()
					require("bookmarks").bookmark_ann()
				end,
				desc = "Edit mark",
			},
			{
				"<leader>ml",
				function()
					require("telescope").extensions.bookmarks.list()
				end,
				desc = "List marks",
			},
		},
		opts = {
			save_file = vim.fn.expand("$HOME/.config/nvim/.bookmarks"),
			keywords = {
				["@t"] = " ",
				["@w"] = " ",
				["@f"] = "⛏ ",
				["@n"] = " ",
			},
		},
	},
}
