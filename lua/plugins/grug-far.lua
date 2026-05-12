-- Used for project wide find-and-replace
return {
	"MagicDuck/grug-far.nvim",
	cmd = { "GrugFar", "GrugFarWithin" },
	keys = {
		{ "<leader>rr", "<cmd>GrugFar<CR>", desc = "Open find and replace" },
		{ "<leader>rf", "<cmd>GrugFarWithin<CR>", desc = "Open find and replace for open buffer" },
		{
			"<leader>rvv",
			function()
				require("grug-far").with_visual_selection()
			end,
			mode = { "v" },
			desc = "Open find and replace for visual selection",
		},
		{
			"<leader>rvf",
			function()
				require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
			end,
			mode = { "v" },
			desc = "Open find and replace for visual selection for file",
		},
	},
	config = function()
		require("grug-far").setup()
	end,
}
