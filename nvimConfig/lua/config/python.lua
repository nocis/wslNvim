local venv_path = vim.fn.expand("~/.virtualenvs/neovim")
local python_path = venv_path .. "/bin/python3"

local function setup_python_host()
	-- If it already exists and is healthy, just set it and exit
	if vim.fn.filereadable(python_path) == 1 and vim.fn.executable(python_path) == 1 then
		vim.notify("Python host already exists and is healthy at " .. venv_path, vim.log.levels.INFO)
		vim.g.python3_host_prog = python_path
		return
	end

	-- If the directory exists but the python executable is missing/dead, nuke it
	if vim.fn.isdirectory(venv_path) == 1 then
		vim.notify("Found broken or outdated venv. Removing it...", vim.log.levels.WARN)
		vim.cmd("redraw")
		vim.fn.delete(venv_path, "rf") -- Equivalent to `rm -rf`
	end

	vim.notify("Creating Python host virtualenv...", vim.log.levels.INFO)
	vim.cmd("redraw") -- Force UI update so the notification shows before blocking

	local sys_python = vim.fn.executable("python3") == 1 and "python3" or "python"
	if vim.fn.executable(sys_python) ~= 1 then
		vim.notify("Error: No system Python found. Please install Python 3.", vim.log.levels.ERROR)
		return
	end

	-- 1. Create base directory if needed
	local venv_dir = vim.fn.fnamemodify(venv_path, ":h")
	if vim.fn.isdirectory(venv_dir) == 0 then
		vim.fn.mkdir(venv_dir, "p")
	end

	-- 2. Create venv
	local create_cmd = string.format("%s -m venv %s", sys_python, venv_path)
	local result = vim.fn.system(create_cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to create virtualenv: " .. result, vim.log.levels.ERROR)
		return
	end

	-- 3. Install pynvim
	local pip = venv_path .. "/bin/pip"
	local install_cmd = string.format("%s install pynvim", pip)
	result = vim.fn.system(install_cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to install pynvim: " .. result, vim.log.levels.ERROR)
		return
	end

	vim.notify("Python host virtualenv created successfully.", vim.log.levels.INFO)

	-- Set the host variable for the current session
	vim.g.python3_host_prog = python_path
end

-- Create the user command :PythonInit
vim.api.nvim_create_user_command("PythonInit", setup_python_host, {
	desc = "Initialize or fix Python virtual environment for Neovim host",
})

-- On Neovim startup, check if the venv exists AND is not dead.
if vim.fn.filereadable(python_path) == 1 and vim.fn.executable(python_path) == 1 then
	-- Healthy: just set it silently
	vim.g.python3_host_prog = python_path
else
	vim.notify("Python env .virtualenvs/neovim Dead, please run :PythonInit", vim.log.levels.ERROR)
end

-- 1. check currently selected pyenv python version
-- 2. if not correctly set python version, the created venv will not working
-- 3. check created venv
--
