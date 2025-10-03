return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	"nvim-neotest/neotest-python",
	{ "fredrikaverpil/neotest-golang", tag = "v1.15.1" }, -- TODO: remove tag on treesitter upgrade
}
