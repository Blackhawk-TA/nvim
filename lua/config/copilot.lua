local system = require("utils.system")

if not system.is_work_device() then
	return
end

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()

vim.keymap.set("n", "<leader>ce", function()
	vim.cmd("Copilot enable")
	print("Copilot enabled")
end)
vim.keymap.set("n", "<leader>cd", function()
	vim.cmd("Copilot disable")
	print("Copilot disabled")
end)
