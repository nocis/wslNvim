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

-- Run cmake on CMakeLists.txt save
local cmake_job_id = nil

vim.api.nvim_create_autocmd("BufWritePost", { -- Use BufWritePost instead of BufWritePre
	group = vim.api.nvim_create_augroup("cmaketools", { clear = true }),
	pattern = "CMakeLists.txt",
	callback = function()
		-- Cancel previous job if still running
		if cmake_job_id then
			vim.fn.jobstop(cmake_job_id)
		end

		vim.notify("Running cmake build...", vim.log.levels.INFO)

		-- Run asynchronously with jobstart
		cmake_job_id = vim.fn.jobstart({ "bash", "build.sh" }, {
			on_stdout = function(_, data)
				if data then
					local output = table.concat(data, "\n")
					if output ~= "" then
						print(output)
					end
				end
			end,
			on_stderr = function(_, data)
				if data then
					local output = table.concat(data, "\n")
					if output ~= "" then
						vim.notify(output, vim.log.levels.WARN)
					end
				end
			end,
			on_exit = function(_, exit_code)
				cmake_job_id = nil
				if exit_code == 0 then
					vim.notify("✓ CMake build successful", vim.log.levels.INFO)
				else
					vim.notify("✗ CMake build failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
				end
			end,
			stdout_buffered = true,
			stderr_buffered = true,
		})
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	-- pattern = "css,eruby,html,htmldjango,javascriptreact,less,pug,sass,scss,typescriptreact",

	pattern = "html",
	callback = function()
		if not vim.fs.root(0, "node_modules") then
			return
		end
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
		if not vim.fs.root(0, "node_modules") then
			return
		end
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
