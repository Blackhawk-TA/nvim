return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"princejoogie/dir-telescope.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		keys = {
			{ "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
			{ "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
			{ "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
			{ "<leader>fr", function() require("telescope.builtin").lsp_references() end, desc = "LSP References" },
			{ "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
			{ "<leader>fy", "<cmd>Telescope neoclip extra=star,plus<CR>", desc = "Neoclip" },
			{ "<leader>fd", "<cmd>Telescope dir live_grep<CR>", desc = "Dir Live Grep" },
		},
	},
}
