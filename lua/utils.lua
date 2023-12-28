local utils = {}

function utils.is_editable()
	local current_buffer = vim.fn.bufnr("%")
	local is_modifiable = vim.api.nvim_buf_get_option(current_buffer, "modifiable")
	local is_readonly = vim.api.nvim_buf_get_option(current_buffer, "readonly")
	return is_modifiable and not is_readonly
end

function utils.start_debugger()
	if vim.fn.filereadable(".vscode/launch.json") then
		require("dap.ext.vscode").load_launchjs()
	end
	require("dap").continue()
end

function utils.get_mason_dir(package_name)
	local mason_registry = require("mason-registry")
	local package = mason_registry.get_package(package_name)
	return package:get_install_path()
end

function utils.get_python_path()
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return utils.get_mason_dir("debugpy") .. "/venv/bin/python"
	end
end

return utils
