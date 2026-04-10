return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
				build = function()
					vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
				end,
			},
		},
		keys = {
			{
				"<leader>uu",
				function()
					vim.cmd("silent! w")
					require("neotest").run.run()
				end,
				desc = "Run Nearest Test",
			},
			{
				"<leader>uf",
				function()
					vim.cmd("silent! w")
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run File Tests",
			},
			{
				"<leader>ud",
				function()
					vim.cmd("silent! w")
					require("neotest").run.run({ strategy = "dap" })
				end,
				desc = "Debug Nearest Test",
			},
			{
				"<leader>U",
				function()
					vim.cmd("silent! w")
					require("neotest").run.stop()
				end,
				desc = "Stop Nearest Test",
			},
			{ "<leader>us", "<cmd>Neotest summary<cr>", desc = "Test Summary" },
		},
		config = function()
			require("config/neotest")
		end,
	},
}
