require("swagger-preview").setup({
	-- The port to run the preview server on
	port = 8787,
	-- The host to run the preview server on
	host = "localhost",
})

vim.keymap.set("n", "<leader>sp", "<cmd>SwaggerPreviewToggle<cr>")
