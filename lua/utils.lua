local utils = {
	neotree_open_before_debug = nil,
	autoclose_debug_windows = false,
	debugging = false,
	pre_debug_file_in_buffer = nil,
	pre_debug_buffer = nil,
}

function utils.is_editable()
	local current_buffer = vim.fn.bufnr("%")
	local is_modifiable = vim.api.nvim_buf_get_option(current_buffer, "modifiable")
	local is_readonly = vim.api.nvim_buf_get_option(current_buffer, "readonly")
	return is_modifiable and not is_readonly
end

function utils.store_current_buffer()
	utils.pre_debug_buffer = vim.fn.bufnr("%")
	utils.pre_debug_file_in_buffer = vim.fn.bufname("%")
end

function utils.restore_current_buffer()
	-- Set the previous buffer as the current buffer
	if utils.pre_debug_buffer then
		vim.cmd("buffer " .. utils.pre_debug_buffer)
	end
	-- Open the previous file in the buffer
	if utils.pre_debug_file_in_buffer then
		vim.cmd("edit " .. utils.pre_debug_file_in_buffer)
	end
end

function utils.start_debugger(autoclose_windows)
	if not utils.debugging then
		utils.debugging = true
		utils.autoclose_debug_windows = autoclose_windows
		if utils.is_editable() then
			vim.cmd("silent! wall")
		end

		local cwd = vim.fn.getcwd()
		local config_path = cwd .. "/.vscode/launch.json"
		if vim.fn.filereadable(config_path) then
			require("dap.ext.vscode").load_launchjs(config_path, {
				codelldb = { "c", "cpp", "rust" },
			})
		end
	end
	require("dap").continue()
end

function utils.close_debugger()
	utils.debugging = false
	require("dapui").close()
	if not utils.is_neotree_open() and utils.neotree_open_before_debug == true then
		utils.neotree_open_before_debug = false
		vim.cmd("Neotree show")
	end
end

function utils.get_mason_dir(package_name)
	local mason_registry = require("mason-registry")
	local package = mason_registry.get_package(package_name)
	return package:get_install_path()
end

function utils.get_mason_binary(package_name)
	return utils.get_mason_dir(package_name) .. "/" .. package_name
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

function utils.is_neotree_open()
	local manager = require("neo-tree.sources.manager")
	local renderer = require("neo-tree.ui.renderer")
	local state = manager.get_state("filesystem")
	local window_exists = renderer.window_exists(state)
	return window_exists
end

function utils.get_username()
	local f = io.popen("whoami")
	local username = ""
	if f ~= nil then
		username = f:read("*a")
		username = username:gsub("%s+", "")
		f:close()
	end
	return username
end

function utils.is_work_device()
	local username = utils.get_username()
	return string.match(username, "D%d%d%d%d%d%d")
end

return utils
