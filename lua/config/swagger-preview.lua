local utils = require("utils")

require("swagger-preview").setup({
	-- The port to run the preview server on
	port = 8787,
	-- The host to run the preview server on
	host = "localhost",
})

local preview_active = false

vim.keymap.set("n", "<leader>ps", function()
	if preview_active then
		vim.cmd("SwaggerPreviewStop")
		print("Stopped swagger preview server")
		preview_active = false
	else
		vim.cmd("SwaggerPreview")
		preview_active = true
		utils.open_browser("http://localhost:8787")
	end
end)
