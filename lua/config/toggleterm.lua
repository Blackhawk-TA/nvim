require("toggleterm").setup{
	terminal_mappings = true,
}

vim.keymap.set("n", "<leader>tt", ":1ToggleTerm direction=horizontal<cr>")
vim.keymap.set("n", "<leader>tf", ":2ToggleTerm direction=float<cr>")
