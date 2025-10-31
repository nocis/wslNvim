return {
	"L3MON4D3/LuaSnip",
	config = function()
		-- Load standard friendly snippets (optional)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets/json" } })

		-- Load snippets from your custom "config/snippets/lua" directory
		require("luasnip.loaders.from_lua").load({ paths = { vim.fn.stdpath("config") .. "/snippets/lua" } })
	end,
}
