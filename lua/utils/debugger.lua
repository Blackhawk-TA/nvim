local utils = require("utils.utils")
local debugger = {
	neotree_open_before_debug = nil,
	autoclose_debug_windows = false,
	debugging = false,
	pre_debug_window = nil,
	pre_debug_buffer = nil,
	pre_debug_file_in_buffer = nil,
}

function debugger.store_current_buffer()
	if utils.is_editable() then
		vim.cmd("silent! wall")
		debugger.pre_debug_window = vim.api.nvim_get_current_win()
		debugger.pre_debug_buffer = vim.api.nvim_win_get_buf(debugger.pre_debug_window)
		debugger.pre_debug_file_in_buffer = vim.api.nvim_buf_get_name(debugger.pre_debug_buffer)
	end
end

function debugger.restore_current_buffer()
	vim.cmd("silent! wall")
	-- Set the previous window and buffer as the current one if they are valid
	local is_valid_window = debugger.pre_debug_window and vim.api.nvim_win_is_valid(debugger.pre_debug_window)
	local is_valid_buffer = debugger.pre_debug_buffer and vim.api.nvim_buf_is_valid(debugger.pre_debug_buffer)
	if is_valid_window and is_valid_buffer then
		vim.api.nvim_set_current_win(debugger.pre_debug_window)
		vim.api.nvim_set_current_buf(debugger.pre_debug_buffer)
	end
	-- Open the previous file in the buffer
	local file_path = debugger.pre_debug_file_in_buffer
	if file_path and vim.fn.filereadable(file_path) == true then
		vim.cmd("edit " .. file_path)
	end
end

function debugger.start_debugger(autoclose_windows)
	if not debugger.debugging then
		debugger.debugging = true
		debugger.autoclose_debug_windows = autoclose_windows
		if utils.is_editable() then
			vim.cmd("silent! wall")
		end
	end
	require("dap").continue()
end

function debugger.close_debugger()
	debugger.debugging = false
	require("dapui").close()
	if not utils.is_neotree_open() and debugger.neotree_open_before_debug == true then
		debugger.neotree_open_before_debug = false
		vim.cmd("Neotree show")
	end
end

return debugger
