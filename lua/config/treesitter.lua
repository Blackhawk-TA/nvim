local treesitter = require("nvim-treesitter")

local install_languages = {
	"c",
	"cpp",
	"rust",
	"make",
	"go",
	"java",
	"javascript",
	"typescript",
	"html",
	"css",
	"python",
	"bash",
	"lua",
	"vim",
	"vimdoc",
	"markdown",
	"markdown_inline",
	"json",
	"jsonc",
	"xml",
	"yaml",
	"regex",
	"dockerfile",
}

treesitter.install(install_languages):wait(300000) -- wait max. 5 minutes

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"cpp",
		"rust",
		"make",
		"go",
		"java",
		"javascript",
		"typescript",
		"html",
		"css",
		"python",
		"sh",
		"zsh",
		"lua",
		"vim",
		"vimdoc",
		"markdown",
		"json",
		"jsonc",
		"xml",
		"yaml",
		"regex",
		"dockerfile",
	},

	callback = function()
		-- syntax highlighting, provided by Neovim
		vim.treesitter.start()
		-- folds, provided by Neovim
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- indentation, provided by nvim-treesitter
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- Handle cases where parses differ from filetype
vim.treesitter.language.register("bash", { "zsh" })
