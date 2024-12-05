local utils = require("utils")

if not utils.is_work_device() then
	return {}
end

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
	},
}
