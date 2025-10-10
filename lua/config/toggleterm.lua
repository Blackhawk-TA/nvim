require("toggleterm").setup({
	terminal_mappings = true,
})

vim.keymap.set("n", "<leader>ta", ":ToggleTermToggleAll<cr>")
vim.keymap.set("n", "<leader>tt", ":ToggleTerm<cr>")

for i = 1, 8 do
	vim.keymap.set("n", "<leader>t" .. i, ":" .. i .. "ToggleTerm direction=horizontal name=Term" .. i .. "<cr>")
end

vim.keymap.set("n", "<leader>tf", ":9ToggleTerm direction=float<cr>")
