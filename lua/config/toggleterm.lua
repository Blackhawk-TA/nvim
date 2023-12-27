require("toggleterm").setup{
	open_mapping = [[<leader>tt]],
	terminal_mappings = true,
}

vim.keymap.set("n", "<leader>tf", ":2ToggleTerm direction=float<cr>")
