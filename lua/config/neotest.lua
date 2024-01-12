require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-go"),
	},
})

-- Run nearest test
vim.keymap.set("n", "<leader>uu", "<cmd>lua require('neotest').run.run()<cr>")

-- Run current file
vim.keymap.set("n", "<leader>uf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>")

-- Debug nearest test
vim.keymap.set("n", "<leader>ud", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>")

-- Stop nearest test
vim.keymap.set("n", "<leader>U", "<cmd>lua require('neotest').run.stop()<cr>")
