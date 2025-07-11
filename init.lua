require("settings")

require("config/lazy")
require("config/colorscheme")

require("config/neotree")
require("config/lualine")
require("config/comment")
require("config/hop")
require("config/autopairs")
require("config/toggleterm")
require("config/bufferline")
require("config/telescope")
require("config/treesitter")
require("config/debugging")
require("config/nvim-lint")
require("config/git")
require("config/trouble")
require("config/neotest")
require("config/refactoring")
require("config/markdown-preview")
require("config/swagger-preview")
require("config/colorizer")
require("config/makeit")
require("config/diagnostic")
require("config/cmp")
require("config/mason")
require("config/conform")

-- Copilot is only supported on work devices
require("config/copilot")
require("config/copilot-chat")

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
	"yamlls"
})

require("after/plugin/autocmd")
require("after/plugin/keymap")
