local root_files = {
	".git",
	".clangd",
	"compile_commands.json",
}

-- Support clangd compile-commands.json
vim.lsp.config("clangd", {
	cmd = { "clangd", "--compile-commands-dir=build" },
	root_markers = root_files,
	filetypes = { "c", "cpp", "h", "hpp" },
	root_dir = function()
		return vim.fn.getcwd()
	end,
})
