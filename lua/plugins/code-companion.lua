local system = require("utils.system")

if not system.is_work_device() then
	return {}
end

return {
	"olimorris/codecompanion.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"franco-ruggeri/codecompanion-spinner.nvim",
	},
}
