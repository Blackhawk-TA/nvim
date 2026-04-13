return {
	"smoka7/hop.nvim",
	version = "*",
	cmd = { "HopWord", "HopLine", "HopChar1", "HopChar2" },
	keys = {
		{ " ", "<cmd>HopWord<cr>", desc = "Hop Word" },
	},
	config = function()
		require("config/hop")
	end,
}
