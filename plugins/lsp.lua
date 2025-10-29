return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ['*'] = {
          keys = {
            -- disable signature help in insert mode
            { "<c-k>", false, mode = "i" }
          },
        },
        cssmodules_ls = {},
        graphql = {},
        somesass_ls = {},
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
