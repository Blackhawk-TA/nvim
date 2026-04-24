-- toggle_swagger_preview starts or stops the swagger preview depending on the current state
local function toggle_swagger_preview()
	local system = require("utils.system")
	-- Use a global to track state across invocations
	if vim.g.swagger_preview_active then
		vim.cmd("SwaggerPreviewStop")
		vim.notify("Stopped swagger preview server", vim.log.levels.INFO)
		vim.g.swagger_preview_active = false
	else
		vim.cmd("SwaggerPreview")
		vim.g.swagger_preview_active = true
		system.open_browser("http://localhost:8787")
	end
end

return {
	"vinnymeller/swagger-preview.nvim",
	cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
	build = "npm i",
	keys = {
		{ "<leader>ps", toggle_swagger_preview, desc = "Toggle Swagger Preview" },
	},
	config = function()
		require("config/swagger-preview")
	end,
}
