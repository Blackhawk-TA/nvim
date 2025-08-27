local utils = require("utils")

-- Only use local config for git repos
local typos_config_path = vim.fn.stdpath("config") .. "/.nvim-spell/typos.toml"
if utils.is_git_repo() then
	typos_config_path = vim.fn.getcwd() .. "/.nvim-spell/typos.toml"
end

vim.lsp.config("typos_lsp", {
	settings = {
		init_options = {
			config = typos_config_path,
			diagnosticSeverity = "Error",
		},
		flags = {
			debounce_text_changes = 150,
		},
	},
})

local file_created = utils.ensure_file_exists(typos_config_path)
if file_created then
	utils.append_file(typos_config_path, "[default.extend-words]\n")
end

local function get_word_under_cursor()
	-- Get the current cursor position (row, col)
	local _, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	local start_col = col
	local end_col = col
	col = col + 1 -- Adjust index due to Lua 1-based indexing

	-- Move start_col to the beginning of the word
	while start_col > 1 and line:sub(start_col - 1, start_col - 1):match("%w") do
		start_col = start_col - 1
	end

	-- Move end_col to the end of the word
	while end_col <= #line and line:sub(end_col, end_col):match("%w") do
		end_col = end_col + 1
	end

	local word = line:sub(start_col, end_col - 1)
	return word
end

local function add_word_to_exceptions()
	local word = get_word_under_cursor()
	local exception_rule = word .. ' = "' .. word .. '"\n'
	utils.append_file(typos_config_path, exception_rule)
	print("Added '" .. word .. "' to typos exceptions")
	-- nvim_lsp.typos_lsp.setup(settings) --TODO: Causes error
end

-- TODO: Missing improvements:
-- - reload on modified config file
-- - add to code_action table if typos_lsp detected error
-- - check for duplicates when adding word
-- - make it its own plugins maybe?

vim.keymap.set("n", "<leader>zg", add_word_to_exceptions)
