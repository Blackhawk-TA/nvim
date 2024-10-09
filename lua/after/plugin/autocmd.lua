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

-- Workaround to update fold
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1337
-- https://www.jmaguire.tech/posts/treesitter_folding/
local augroup = vim.api.nvim_create_augroup("UserTreesitterConfig", {})
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	pattern = "*",
	callback = function()
		if utils.is_editable() then
			vim.cmd("normal zR")
		end
	end
})

-- Set spell file when entering a buffer
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if not utils.is_git_repo() then
			return
		end
		local spellfile = vim.fn.getcwd() .. "/.nvim-spell/en.utf-8.add"
		utils.ensure_file_exists(spellfile)
		if vim.fn.filereadable(spellfile) then
			vim.opt.spellfile = spellfile
		end
	end
})

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
