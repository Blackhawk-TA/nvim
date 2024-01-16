local utils = require("utils")

if not utils.is_work_device() then
	return
end

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})
require("copilot_cmp").setup()
