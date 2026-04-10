return {
	"stevearc/conform.nvim",
	opts = {},
	event = "BufWritePre",
	config = function()
		require("config/conform")
	end,
}
