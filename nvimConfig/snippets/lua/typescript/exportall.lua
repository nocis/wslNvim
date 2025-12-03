local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

-- Helper function to capitalize the first letter of a string
local function capitalize(str)
	return str:sub(1, 1):upper() .. str:sub(2)
end

-- Function to generate the export strings dynamically
local function generate_exports()
	local cwd = vim.fn.expand("%:p:h") -- Get the current working directory
	local files = vim.fn.readdir(cwd) -- Read all files in the directory
	local exports = {}
	-- vim.notify("Inspecting data: " .. cwd, vim.log.levels.DEBUG)

	for _, file in ipairs(files) do
		-- Skip the current file and files starting with a dot (e.g., .git, .)
		if file ~= vim.fn.expand("%:t") and not file:match("^%.") then
			-- Remove file extension (e.g., .js, .ts) for the export name
			local module_name = file:match("(.+)%..-$") or file
			-- Optional: Format name (e.g., capitalize, camelCase) as needed
			-- For this example, we'll use a simple name
			local export_name = capitalize(module_name)

			-- Create the export line: export { ExportName } from './filename';
			-- vim.notify("Inspecting data: " .. export_name, vim.log.levels.DEBUG)
			table.insert(exports, string.format("export { default as %s } from './%s';", export_name, file))
		end
	end
	-- Join all lines with a newline character
	return exports
end

return {
	s({
		trig = "exportall",
		dscr = "Exports all files in the current directory as named exports",
	}, {
		f(generate_exports, {}), -- Function node calls generate_exports
	}),
}
