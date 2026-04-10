local system = require("utils.system")

if not system.is_work_device() then
	return
end

require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("copilot_cmp").setup()
