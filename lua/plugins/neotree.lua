return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>bb", "<Cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
		{ "<leader>bv", "<Cmd>Neotree git_status<CR>", desc = "Neo-tree Git Status" },
	},
}
