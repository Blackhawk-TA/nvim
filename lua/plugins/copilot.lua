local system = require("utils.system")

if not system.is_work_device() then
	return {}
end

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		copilot_model = "gpt-5.1",
		event = "InsertEnter",
		opts = {
			server_opts_overrides = {
				settings = {
					telemetry = {
						telemetryLevel = "off",
					},
				},
			},
		},
		keys = {
			{
				"<leader>ce",
				function()
					vim.cmd("Copilot enable")
					print("Copilot enabled")
				end,
				desc = "Copilot Enable",
			},
			{
				"<leader>cd",
				function()
					vim.cmd("Copilot disable")
					print("Copilot disabled")
				end,
				desc = "Copilot Disable",
			},
		},
		config = function()
			require("config/copilot")
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = { "InsertEnter", "LspAttach" },
		fix_pairs = true,
	},
}
