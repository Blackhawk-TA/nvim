return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		require("config/conform")
	end,
}
