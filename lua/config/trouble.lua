require("trouble").setup({
	signs = {
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "",
	},
})

vim.keymap.set("n", "<leader>zz", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>zw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>zf", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>zr", "<cmd>TroubleToggle lsp_references<cr>")
vim.keymap.set("n", "<leader>zd", "<cmd>TroubleToggle lsp_definitions<cr>")
vim.keymap.set("n", "<leader>zq", "<cmd>TroubleToggle quickfix<cr>")
