local system = require("utils.system")

if not system.is_work_device() then
	return {}
end

return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		copilot_model = "gpt-5-mini",
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
	},
	{
		"zbirenbaum/copilot-cmp",
		event = { "InsertEnter", "LspAttach" },
		fix_pairs = true,
	},
}
