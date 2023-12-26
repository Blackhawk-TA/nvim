require("toggleterm").setup{
	open_mapping = [[<leader>tt]],
	terminal_mappings = true,
}

vim.keymap.set("n", "<leader>tf", ":ToggleTerm direction=float<cr>")
