local utils = {}

--- Checks if the Neo-tree file explorer window is currently open.
-- @return boolean: true if the Neo-tree window exists, false otherwise.
function utils.is_neotree_open()
	local manager = require("neo-tree.sources.manager")
	local renderer = require("neo-tree.ui.renderer")
	local state = manager.get_state("filesystem")
	local window_exists = renderer.window_exists(state)
	return window_exists
end

--- Checks if any ToggleTerm terminal is currently open.
-- @return boolean True if at least one terminal is open, false otherwise.
function utils.is_terminal_open()
	local terminals = require("toggleterm.terminal").get_all()
	for _, term in pairs(terminals) do
		if term:is_open() then
			return true
		end
	end
	return false
end

-- Checks if the current buffer is editable.
-- @return boolean # true if the buffer is editable, false otherwise.
function utils.is_editable()
	local current_buffer = vim.fn.bufnr("%")
	local is_modifiable = vim.api.nvim_get_option_value("modifiable", { buf = current_buffer })
	local is_readonly = vim.api.nvim_get_option_value("readonly", { buf = current_buffer })
	return is_modifiable and not is_readonly
end

-- Returns a special hint character depending on the user's OS.
-- On macOS, returns a different icon than on other systems.
-- @return string: The hint character for the current OS.
function utils.get_hint_char()
	local hint_char = "󰌵"
	if vim.fn.has("macunix") == 1 then
		hint_char = ""
	end
	return hint_char
end

return utils
