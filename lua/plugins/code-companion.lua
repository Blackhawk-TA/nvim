local utils = require("utils")

if not utils.is_work_device() then
	return
end

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}
