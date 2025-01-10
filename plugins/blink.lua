return {
  {
    "saghen/blink.cmp",

    opts = function(_, opts)
      opts.completion.list = opts.completion.list or { selection = {} }
      opts.completion.list.selection = { preselect = false, auto_insert = false }

      opts.completion.menu = opts.completion.menu
        or { draw = {
          treesitter = { "lsp" },
        }, direction_priority = {} }
      opts.completion.menu.direction_priority = { "n", "s" }

      opts.completion.trigger = opts.completion.trigger or {}
      opts.completion.trigger.show_on_blocked_trigger_characters = {}

      -- add newline, tab and space to LSP source
      opts.sources.providers.lsp = opts.sources.providers.lsp or { override = {} }
      opts.sources.providers.lsp.override.get_trigger_characters = function(self)
        local trigger_characters = self:get_trigger_characters()
        vim.list_extend(trigger_characters, { "\n", "\t", " " })
        return trigger_characters
      end
    end,
  },
}
