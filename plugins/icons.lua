return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "echasnovski/mini.icons",
    },
    opts = {
      filesystem = {
        components = {
          icon = function(config, node, state)
            if node.type == "directory" then
              local icon, hl, is_default = require("mini.icons").get("directory", node.name)
              local curIcon = {
                text = icon or "*",
                highlight = hl,
              }
              if node.loaded and not node:has_children() then
                curIcon.text = not node.empty_expanded and curIcon.text
              elseif node:is_expanded() then
                curIcon.text = " " .. curIcon.text
              else
                curIcon.text = " " .. curIcon.text
              end
              return curIcon
            end
            local rawIcon = require("neo-tree.sources.common.components").icon(config, node, state)
            rawIcon.text = "└ " .. rawIcon.text
            return rawIcon
          end,
        },
      },
    },
  },
  {
    "echasnovski/mini.icons",
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
