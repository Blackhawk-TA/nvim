return {
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		init = function()
			-- Use lazygit config in nvim config root directory
			vim.g.lazygit_use_custom_config_file_path = 1
			vim.g.lazygit_config_file_path = vim.fn.stdpath("config") .. "/lazygit.yaml"
		end,
		keys = {
			{
				"<leader>go",
				function()
					require("telescope").load_extension("lazygit")
					require("telescope").extensions.lazygit.lazygit()
				end,
			},
			{ "<leader>gg", "<cmd>LazyGit<cr>" },
			{ "<leader>gh", "<cmd>LazyGitFilter<cr>" },
			{ "<leader>ghf", "<cmd>LazyGitFilterCurrentFile<cr>" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("config/git")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewRefresh", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gvv", "<cmd>DiffviewOpen<cr>" },
			{ "<leader>gvc", "<cmd>DiffviewClose<cr>" },
			{ "<leader>gvr", "<cmd>DiffviewRefresh<cr>" },
			{ "<leader>gvh", "<cmd>DiffviewFileHistory<cr>" },
			{ "<leader>gvf", "<cmd>DiffviewFileHistory %<cr>" },
		},
	},
}
