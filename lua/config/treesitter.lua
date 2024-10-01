require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
	ensure_installed = {
		"c",
		"cpp",
		"rust",
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
		"dockerfile"
	}
})

