local utils = require("utils")

if not utils.is_work_device() then
	return {}
end

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"zbirenbaum/copilot-cmp",
		event = { "InsertEnter", "LspAttach" },
		fix_pairs = true,
	}
}
