require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-golang"),
	},
})

-- Run nearest test
vim.keymap.set("n", "<leader>uu", function()
	vim.cmd("silent! w")
	require("neotest").run.run()
end)

-- Run current file
vim.keymap.set("n", "<leader>uf", function()
	vim.cmd("silent! w")
	require("neotest").run.run(vim.fn.expand("%"))
end)

-- Debug nearest test
vim.keymap.set("n", "<leader>ud", function()
	vim.cmd("silent! w")
	require("neotest").run.run({ strategy = "dap" })
end)

-- Stop nearest test
vim.keymap.set("n", "<leader>U", function()
	vim.cmd("silent! w")
	require("neotest").run.stop()
end)

-- Show test summary
vim.keymap.set("n", "<leader>us", function()
	vim.cmd("Neotest summary")
end)
