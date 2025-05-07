-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- disable c-a c-x after plugin
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   group = vim.api.nvim_create_augroup("LazyKeymaps", { clear = true }),
--   pattern = "*",
--   command = "map <C-a> gg<S-v>G",
--   desc = "remap c-a to select all",
-- })
-- map works, nn and nmap not working!!!
-- really bad idea!!! conflicts bad!!

-- Treat .ejs files as .html
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ejs",
  command = "set filetype=html",
})

-- Treat .frag and .vert shader files as .glsl
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.frag", "*.vert" },
  command = "set filetype=glsl",
})

-- disable paste mode when insert leave
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- run camke
local cmake_timer
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("cmaketools", { clear = true }),
  pattern = "CMakeLists.txt",
  callback = function()
    cmake_timer = vim.loop.new_timer()

    local on_exit = function(obj)
      -- print(obj.code)
      -- print(obj.signal)
      print(obj.stdout)
      print(obj.stderr)
    end
    local buf = vim.api.nvim_get_current_buf()
    -- Check if buffer is actually modified, and only if it is modified,
    local buf_modified = vim.api.nvim_get_option_value("modified", { buf = buf })
    if buf_modified then
      cmake_timer:start(100, 0, function()
        cmake_timer:close()
        cmake_timer = nil
        vim.schedule(function()
          vim.notify(vim.fn.system({ "bash", "build.sh" }), vim.log.levels.INFO, {})
        end)
      end)
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  -- pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",

  pattern = "html",
  callback = function()
    vim.lsp.start({
      name = "emmet-language-server-css",
      cmd = { vim.fs.root(0, "node_modules") .. "/node_modules/.bin/emmet-language-server", "--stdio" },

      -- vim.fs.find work with cwd, not buffer opened file path
      -- use vim.fs.root , until find first parent dir contains target file

      -- root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      root_dir = vim.fs.root(0, "node_modules"),
      -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- **Note:** only the options listed in the table are supported.
      init_options = {
        ---@type table<string, string>
        includeLanguages = {
          html = "css",
        },
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",
  callback = function()
    vim.lsp.start({
      name = "emmet-language-server",
      cmd = { vim.fs.root(0, "node_modules") .. "/node_modules/.bin/emmet-language-server", "--stdio" },

      -- vim.fs.find work with cwd, not buffer opened file path
      -- use vim.fs.root , until find first parent dir contains target file

      -- root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
      root_dir = vim.fs.root(0, "node_modules"),
      -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
      -- **Note:** only the options listed in the table are supported.
      init_options = {
        ---@type table<string, string>
        includeLanguages = {},
        --- @type string[]
        excludeLanguages = {},
        --- @type string[]
        extensionsPath = {},
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
        preferences = {},
        --- @type boolean Defaults to `true`
        showAbbreviationSuggestions = true,
        --- @type "always" | "never" Defaults to `"always"`
        showExpandedAbbreviation = "always",
        --- @type boolean Defaults to `false`
        showSuggestionsAsSnippets = false,
        --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
        syntaxProfiles = {},
        --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
        variables = {},
      },
    })
  end,
})
