return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	"nvim-neotest/neotest-python",
	-- TODO: Still not working after treesitter upgrade.
	-- References:
	-- - https://github.com/fredrikaverpil/neotest-golang?tab=readme-ov-file
	-- - https://fredrikaverpil.github.io/neotest-golang/install/
	"fredrikaverpil/neotest-golang",
}
