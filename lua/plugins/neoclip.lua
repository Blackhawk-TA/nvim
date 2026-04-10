return {
	"AckslD/nvim-neoclip.lua",
	event = "TextYankPost",
	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		require("neoclip").setup()
	end,
}
