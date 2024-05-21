-- Support typos-lsp local config
local nvim_lsp = require('lspconfig')
local typos_config_path = vim.fn.getcwd() .. "/.nvim-spell/typos.toml"
nvim_lsp.typos_lsp.setup {
	cmd = { "typos-lsp", "--config", typos_config_path },
	flags = {
		debounce_text_changes = 150,
	}
}

