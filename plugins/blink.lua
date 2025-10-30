return {
	{
		"saghen/blink.cmp",

		-- opts = function(_, opts)
		-- 	opts.completion.list = opts.completion.list or { selection = {} }
		-- 	opts.completion.list.selection = { preselect = false, auto_insert = false }
		--
		-- 	opts.completion.menu = opts.completion.menu
		-- 		or { draw = {
		-- 			treesitter = { "lsp" },
		-- 		}, direction_priority = {} }
		-- 	opts.completion.menu.direction_priority = { "n", "s" }
		--
		-- 	-- opts.completion.trigger = opts.completion.trigger or {}
		-- 	-- opts.completion.trigger.show_on_blocked_trigger_characters = {}
		--
		-- 	-- add newline, tab and space to LSP source
		-- 	-- opts.sources.providers.lsp = opts.sources.providers.lsp or { override = {} }
		-- 	-- opts.sources.providers.lsp.override.get_trigger_characters = function(self)
		-- 	--   local trigger_characters = self:get_trigger_characters()
		-- 	--   vim.list_extend(trigger_characters, { "\n", "\t", " " })
		-- 	--   return trigger_characters
		-- 	-- end
		-- end,

		opts = {
			fuzzy = { implementation = "prefer_rust" },

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
					-- auto_show = function(ctx)
					-- 	return ctx.mode ~= "cmdline"
					-- end,
				},
				trigger = {
					-- show_on_insert_on_trigger_character = true,
					-- show_on_x_blocked_trigger_characters = { "'", '"', "(", "[", "{" },
					show_on_blocked_trigger_characters = { " ", "\n", "\t" },
				},
				-- list = {
				-- 	selection = {
				-- 		preselect = function(ctx)
				-- 			return ctx.mode ~= "cmdline"
				-- 		end,
				-- 		auto_insert = function(ctx)
				-- 			return ctx.mode ~= "cmdline"
				-- 		end,
				-- 	},
				-- },
			},
		},
		opts_extend = { "sources.default" },
	},
}
