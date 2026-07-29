return {
	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", false }, -- Disable default increment
			{ "<C-x>", false }, -- Disable default decrement
			-- Add your custom mappings here if needed
			{ "+", "<plug>(dial-increment)", mode = "n" },
			{ "-", "<plug>(dial-decrement)", mode = "n" },
		},
	},
}
