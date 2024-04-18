require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-go"),
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
	require("neotest").run.run(vim.fn.expand('%'))
end)

-- Debug nearest test
vim.keymap.set("n", "<leader>ud", function()
	vim.cmd("silent! w")
	if vim.bo.filetype == "go" then
		require("dap-go").debg_test()
	else
		require("neotest").run.run({ strategy = 'dap' })
	end
end)

-- Stop nearest test
vim.keymap.set("n", "<leader>U", function()
	vim.cmd("silent! w")
	require("neotest").run.stop()
end)
