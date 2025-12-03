return {
	{
		"BibekBhusal0/nvim-shadcn",
		opts = {},
		cmd = { "ShadcnAdd" },
		keys = {
			{ "<leader>as", desc = "add shadcn" }, -- this doesn't work
			{ "<leader>asa", ":ShadcnAdd<CR>", desc = "Add shadcn component" },
			{ "<leader>asi", ":ShadcnInit<CR>", desc = "Init shadcn" },
			{ "<leader>asI", ":ShadcnAddImportant<CR>", desc = "Add important shadcn component" },
		},
	},
}
