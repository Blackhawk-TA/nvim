return {
	"OXY2DEV/markview.nvim",
	ft = { "markdown", "codecompanion" },
	cmd = "Markview",
	keys = {
		{ "<leader>pmt", "<cmd>Markview Toggle<cr>", desc = "Toggle Markview" },
	},
	opts = {
		preview = {
			filetypes = { "markdown", "codecompanion" },
			ignore_buftypes = {},
		},
	},
}
