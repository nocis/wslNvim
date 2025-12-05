return {
	{
		"saghen/blink.cmp",

		opts = {
			fuzzy = { implementation = "prefer_rust" },

			snippets = {
				preset = "luasnip",
			},

			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = false,
					},
				},
				accept = {
					create_undo_point = true,
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					direction_priority = { "s", "n" },
				},
				trigger = {
					show_on_blocked_trigger_characters = { " ", "\n", "\t" },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
