local utils = require("utils")

if not utils.is_work_device() then
	return
end

require("codecompanion").setup({
	display = {
		chat = {
			window = {
				width = 0.35,
				relative = "editor",
				position = "left",
			},
		},
	},
	strategies = {
		chat = {
			name = "copilot",
			model = "gpt-4.1",
		},
		inline = {
			keymaps = {
				accept_change = {
					modes = { n = "ca" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "cr" },
					opts = { nowait = true },
					description = "Reject the suggested change",
				},
				always_accept = {
					modes = { n = "cay" },
				},
			},
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>CodeCompanionActions<cr>")

vim.keymap.set("v", "<leader>cx", function()
	local input = vim.fn.input("Inline prompt: ")
	if input ~= "" then
		vim.cmd("CodeCompanion " .. input)
	end
end)
