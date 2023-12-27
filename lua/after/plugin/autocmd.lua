local utils = require("utils")

 -- Disable spellcheck in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	command = "setlocal nospell"
})

-- Auto format on write
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	desc = "formats the buffer on save",
	callback = function()
		if utils.is_editable() then
			-- vim.lsp.buf.format()
			vim.cmd("%s/\\s\\+$//e") -- Remove trailing spaces
		end
	end,
})

-- Auto save and format on focus loss
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	pattern = "*",
	desc = "trigger save when buffer is no longer in focus",
	callback = function()
		if utils.is_editable() then
			-- vim.lsp.buf.format()
			vim.cmd("%s/\\s\\+$//e") -- Remove trailing spaces
			vim.cmd("silent! wall")
		end
	end,
})

