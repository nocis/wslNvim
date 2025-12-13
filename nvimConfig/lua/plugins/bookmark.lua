return {
	{
		"tomasky/bookmarks.nvim",
		lazy = true,
		keys = {
			{
				"<leader><Tab><Tab>",
				function()
					require("bookmarks").bookmark_toggle()
				end,
				desc = "Toggle mark",
			},
			{
				"<leader><Tab>e",
				function()
					require("bookmarks").bookmark_ann()
				end,
				desc = "Edit mark",
			},
			{
				"<leader><Tab>l",
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
