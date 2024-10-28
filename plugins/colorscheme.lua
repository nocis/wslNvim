return {
  "folke/tokyonight.nvim",
  opts = {
    style = "storm",
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(highlights, colors)
      highlights.FlashLabel = {
        bg = "#ff007c",
        fg = "#19486c",
        bold = false,
      }
      --highlights.NeoTreeDimText = {
      -- fg = "#ffffff",
      --}
      --highlights.NeoTreeWindowsHidden = {
      -- fg = "#ffffff",
      --}
      --highlights.NeoTreeDotfile = {
      -- fg = "#ffffff",
      --}
      highlights.NeoTreeMessage = {
        fg = "#777777",
      }
      highlights.DiagnosticUnnecessary = {
        fg = "#777777",
      }
      highlights.MatchParen = {
        bg = "#00d4ef",
        fg = "#140000",
      }
    end,
  },
}
