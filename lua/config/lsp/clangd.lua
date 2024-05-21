-- Support clangd compile-commands.json
local nvim_lsp = require('lspconfig')
nvim_lsp.clangd.setup {
	cmd = { "clangd", "--compile-commands-dir=build" },
	root_dir = function()
		return vim.fn.getcwd()
	end,
}

