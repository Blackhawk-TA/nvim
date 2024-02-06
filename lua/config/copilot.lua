local utils = require("utils")

if not utils.is_work_device() then
	return
end

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()

vim.keymap.set("n", "<leader>ce", "<cmd>Copilot enable<cr>")
vim.keymap.set("n", "<leader>cd", "<cmd>Copilot disable<cr>")
