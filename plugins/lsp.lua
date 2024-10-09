return {
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
