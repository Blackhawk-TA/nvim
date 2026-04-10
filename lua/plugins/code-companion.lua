local system = require("utils.system")

if not system.is_work_device() then
	return {}
end

return {
	"olimorris/codecompanion.nvim",
	version = "*",
	cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"franco-ruggeri/codecompanion-spinner.nvim",
	},
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
		{ "<leader>cf", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{
			"<leader>cx",
			function()
				local input = vim.fn.input("Inline prompt: ")
				if input ~= "" then
					vim.cmd("CodeCompanion " .. input)
				end
			end,
			mode = { "n", "v" },
			desc = "CodeCompanion Inline",
		},
	},
	config = function()
		require("config/code-companion")
	end,
}
