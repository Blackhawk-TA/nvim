local utils = require("utils")

require("swagger-preview").setup({
	-- The port to run the preview server on
	port = 8787,
	-- The host to run the preview server on
	host = "localhost",
})

local preview_active = false

vim.keymap.set("n", "<leader>sp", function()
	if preview_active then
		vim.cmd("SwaggerPreviewStop")
		preview_active = false
	else
		vim.cmd("SwaggerPreview")
		preview_active = true
	end
end)
