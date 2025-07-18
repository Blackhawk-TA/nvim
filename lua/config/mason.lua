require("mason").setup()
require("mason-lspconfig").setup({
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
		"typos_lsp",
		"lua_ls",
		"marksman",
		"pyright",
		"sqlls",
		"lemminx",
		"vimls",
		"yamlls",
	},
	automatic_enable = true,
})

require("mason-tool-installer").setup({
	-- All mason tools that should be installed expect language servers.
	-- The language servers are installed in the lsp-zero config
	ensure_installed = {
		-- Linter
		"cspell",
		"cmakelint",
		"cpplint",
		"editorconfig-checker",
		"golangci-lint",
		"luacheck",
		"markdownlint",
		"mypy",
		"jsonlint",

		-- Formatters
		"autoflake",
		"black",
		"clang-format",
		"prettier",
		"stylua",
		"shfmt",

		-- Debuggers
		"codelldb",
		"delve",
		"debugpy",
	},

	-- if set to true this will check each tool for updates. If updates
	-- are available the tool will be updated. This setting does not
	-- affect :MasonToolsUpdate or :MasonToolsInstall.
	-- Default: false
	auto_update = false,

	-- automatically install / update on startup. If set to false nothing
	-- will happen on startup. You can use :MasonToolsInstall or
	-- :MasonToolsUpdate to install tools and check for updates.
	-- Default: true
	run_on_start = true,

	-- set a delay (in ms) before the installation starts. This is only
	-- effective if run_on_start is set to true.
	-- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
	-- Default: 0
	start_delay = 3000, -- 3 second delay

	-- Only attempt to install if "debounce_hours" number of hours has
	-- elapsed since the last time Neovim was started. This stores a
	-- timestamp in a file named stdpath("data")/mason-tool-installer-debounce.
	-- This is only relevant when you are using "run_on_start". It has no
	-- effect when running manually via ":MasonToolsInstall" etc....
	-- Default: nil
	debounce_hours = 5, -- at least 5 hours between attempts to install/update
})
