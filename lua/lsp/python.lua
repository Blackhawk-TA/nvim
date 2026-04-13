local root_files = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
	".git",
}

vim.lsp.config("pyright", {
	name = "pyright",
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = root_files,
	single_file_support = true,
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})
