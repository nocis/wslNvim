return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

      -- disable signature help in insert mode
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssmodules_ls = {},
        graphql = {},
        cssls = {
          filetypes = { "css", "scss", "less" },
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
          },
        },
        html = {
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = false,
          },
          settings = {
            css = {
              lint = {
                validProperties = {},
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        glsl_analyzer = {},
        -- glslls = {},
      },
    },
  },
}
