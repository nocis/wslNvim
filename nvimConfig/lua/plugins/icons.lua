return {
	{
		"nvim-mini/mini.icons",
		lazy = true,
		opts = {
			file = {
				["eslint.config.mjs"] = { glyph = "󰱺", hl = "MiniIconsYellow" },
				["webpack.config.ts"] = { glyph = "󰜫", hl = "MiniIconsOrange" },
			},
			directory = {
				utils = { glyph = "󱧼", hl = "MiniIconsYellow" },
				public = { glyph = "󱧰", hl = "MiniIconsOrange" },
				Public = { glyph = "󱧰", hl = "MiniIconsOrange" },
				config = { glyph = "󱁿", hl = "MiniIconsCyan" },
				[".config"] = { glyph = "󱁿", hl = "MiniIconsCyan" },
				routes = { glyph = "", hl = "MiniIconsOrange" },
				middlewares = { glyph = "󰲂", hl = "MiniIconsGreen" },
				components = { glyph = "󰲂", hl = "MiniIconsGreen" },
				hooks = { glyph = "󰉗", hl = "MiniIconsAzure" },
				types = { glyph = "", hl = "MiniIconsCyan" },
				src = { glyph = "", hl = "MiniIconsGreen" },
				node_modules = { glyph = "", hl = "MiniIconsPurple" },
				app = { glyph = "󱂵", hl = "MiniIconsGreen" },
				models = { glyph = "󰛫", hl = "MiniIconsYellow" },
				controllers = { glyph = "󰡰", hl = "MiniIconsGreen" },
				services = { glyph = "󱧱", hl = "MiniIconsRed" },
			},
		},
	},
}
