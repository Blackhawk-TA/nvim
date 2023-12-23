local hop = require("hop").setup({
	keys = "etovxqpdzgfblyhckisuran",
})

vim.keymap.set("n", " ", "<cmd>HopWord<cr>")

