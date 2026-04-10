require("settings")

require("config/lazy")
require("config/colorscheme")

require("config/neotree")
require("config/lualine")
require("config/noice")
require("config/comment")
require("config/autopairs")
require("config/bufferline")
require("config/telescope")
require("config/treesitter")
require("config/debugging")
require("config/nvim-lint")
require("config/neotest")
require("config/swagger-preview")
require("config/diagnostic")
require("config/cmp")
require("config/mason")
require("config/conform")
require("config/treesitter-context")

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

require("after/plugin/autocmd")
require("after/plugin/keymap")
