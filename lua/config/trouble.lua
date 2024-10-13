local utils = require("utils")
local hint_sign = utils.get_hint_char() .. " "

require("trouble").setup({
	signs = {
		error = "",
		warning = "",
		hint = hint_sign,
		information = "",
		other = "",
	},
})

vim.keymap.set("n", "<leader>zz", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "<leader>zr", "<cmd>Trouble lsp_references toggle<cr>")
vim.keymap.set("n", "<leader>zd", "<cmd>Trouble lsp_definitions toggle <cr>")
vim.keymap.set("n", "<leader>zq", "<cmd>Trouble quickfix toggle<cr>")
vim.keymap.set("n", "<leader>zt", "<cmd>Trouble telescope toggle<cr>")
vim.keymap.set("n", "<leader>zo", "<cmd>Trouble todo<cr>")
