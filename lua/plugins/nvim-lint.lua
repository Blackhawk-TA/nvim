return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "InsertLeave" },
	config = function()
		require("config/nvim-lint")
	end,
}
