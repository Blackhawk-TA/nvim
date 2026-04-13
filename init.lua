require("settings")

require("config/lazy")
require("config/colorscheme")

require("config/neotree")
require("config/lualine")
require("config/treesitter")
require("config/telescope")
require("config/diagnostic")
require("config/cmp")
require("config/mason")

-- LSP configs
require("lsp/clangd")
require("lsp/go")
require("lsp/lua")
require("lsp/python")
require("lsp/typos")
require("lsp/yaml")
vim.lsp.enable({
	"clangd",
	"gopls",
	"lua_ls",
	"pyright",
	"typos_lsp",
	"yamlls",
})
vim.lsp.codelens.enable(true)

require("after/plugin/autocmd")
require("after/plugin/keymap")
