require("trouble").setup({
	signs = {
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "",
	},
})

vim.keymap.set("n", "<leader>zz", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>")
vim.keymap.set("n", "<leader>zd", "<cmd>Trouble lsp_definitions toggle <cr>")
vim.keymap.set("n", "<leader>zq", "<cmd>Trouble quickfix toggle<cr>")
vim.keymap.set("n", "<leader>zt", "<cmd>Trouble telescope toggle<cr>")
