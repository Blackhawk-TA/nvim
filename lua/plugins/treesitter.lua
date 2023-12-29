return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "windwp/nvim-ts-autotag", "JoosepAlviste/nvim-ts-context-commentstring" },
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	cmd = {
		"TSBufDisable",
		"TSBufEnable",
		"TSBufToggle",
		"TSDisable",
		"TSEnable",
		"TSToggle",
		"TSInstall",
		"TSInstallInfo",
		"TSInstallSync",
		"TSModuleInfo",
		"TSUninstall",
		"TSUpdate",
		"TSUpdateSync",
	},
	opts = {
		highlight = { enable = true },
		incremental_selection = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
	}
}

