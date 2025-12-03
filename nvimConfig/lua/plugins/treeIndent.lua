return {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		indent = { enable = true },
		-- nvim.smartindent has some issue with astro
		-- using treesitter indent solely is better
	},
}
