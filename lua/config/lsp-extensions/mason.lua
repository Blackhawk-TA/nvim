local lsp_zero = require("lsp-zero").preset({})

require("mason").setup()
require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
	},
	ensure_installed = {
		"angularls",
		"bashls",
		"clangd",
		"cmake",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"eslint",
		"gopls",
		"graphql",
		"html",
		"helm_ls",
		"jsonls",
		"ts_ls",
		"taplo",
		"typos_lsp",
		"lua_ls",
		"marksman",
		"pyright",
		"spectral",
		"sqlls",
		"lemminx",
		"vimls",
		"yamlls",
	},
	automatic_enable = true,
})

