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
require("config/formatter")
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

-- Copilot is only supported on work devices
require("config/copilot")
require("config/copilot-chat")

-- LSP configs
require("lsp.clangd")
require("lsp.go")
require("lsp.lua")
require("lsp.typos")
require("lsp.utils")
vim.lsp.enable({
	"clangd",
	"go",
	"luals",
	"typos_lsp"
})

require("after/plugin/autocmd")
require("after/plugin/keymap")
