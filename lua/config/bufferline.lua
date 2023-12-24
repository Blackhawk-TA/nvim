local function get_dir()
	return vim.fn.getcwd()
end

require("bufferline").setup{
	options = {
		mode = "tabs",
		separator_style = "slant",
		-- diagnostics = "nvim_lsp", -- TODO: add once lsp is present
		offsets = {{
			filetype = "neo-tree",
			text = get_dir,
			highlight = "Directory",
			separator = true
		}}
	}
}

