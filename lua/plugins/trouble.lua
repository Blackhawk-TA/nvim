return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>zz", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
		{ "<leader>zd", "<cmd>Trouble lsp_definitions toggle <cr>", desc = "LSP Definitions (Trouble)" },
		{ "<leader>zq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix (Trouble)" },
		{ "<leader>zt", "<cmd>Trouble telescope toggle<cr>", desc = "Telescope (Trouble)" },
		{ "<leader>zo", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
	},
	config = function()
		require("config/trouble")
	end,
}
