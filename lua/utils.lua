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

return utils
