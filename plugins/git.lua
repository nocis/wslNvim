return {
	-- {
	-- 	"tpope/vim-fugitive",
	-- },
	-- {
	-- 	-- amongst your other plugins
	-- 	{ "akinsho/toggleterm.nvim", version = "*", config = true },
	-- },
	{
		"samoshkin/vim-mergetool",
		config = function()
			vim.g.mergetool_layout = "lbr,m"
			vim.g.mergetool_prefer_revision = 'unmodified'
		end,
	},
}
