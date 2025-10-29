return {
  {
    "stevearc/conform.nvim",
    opts = {
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["astro"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "injected" },
        ["markdown.mdx"] = { "injected" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
        ["cpp"] = { "clang_format" },
        ["cmake"] = { "cmake_format" },
        ["python"] = { "ruff", "ruff_organize_imports", "ruff_format" },
      },

      lang_to_ft = {
        python = "python",
      },
    },
  },
}

-- need to format injected/embedded code block in markdown manully
-- <leader>cf
