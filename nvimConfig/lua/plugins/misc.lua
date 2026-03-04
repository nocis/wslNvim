local leet_arg = "leetcode.nvim"

return {
	{
		"kawre/leetcode.nvim",
		lazy = leet_arg ~= vim.fn.argv(0, -1),
		opts = {
			lang = "python3",
			arg = leet_arg,
			injector = { ---@type table<lc.lang, lc.inject>
				["python3"] = {
					imports = function(default_imports)
						-- vim.list_extend(default_imports, { "from .leetcode import *" })
						return { "from .leetcode import *" }
					end,
					after = { "def test():", "    print('test')" },
				},
				["cpp"] = {
					imports = function()
						-- return a different list to omit default imports
						return { "#include <bits/stdc++.h>", "using namespace std;" }
					end,
					after = "int main() {}",
				},
			},
		},
	},
}
