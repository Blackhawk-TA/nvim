---@diagnostic disable: 113
local lsp_zero = require("lsp-zero").preset({})

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	local default_opts = { buffer = bufnr }
	lsp_zero.default_keymaps(default_opts)
	vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", default_opts)
	vim.keymap.set("n", "<leader>d", "<cmd> lua vim.diagnostic.goto_next()<cr>", default_opts)
	vim.keymap.set("n", "<leader>D", "<cmd> lua vim.diagnostic.goto_prev()<cr>", default_opts)
	vim.keymap.set("n", "<leader>r", "<cmd> lua vim.lsp.buf.rename()<cr>", default_opts)
	vim.keymap.set("n", "<leader>cf", "<cmd> lua vim.lsp.buf.format()<cr>", default_opts)
	vim.keymap.set("n", "<leader>k", "<cmd> lua vim.diagnostic.open_float()<cr>", default_opts)
	vim.keymap.set({ "n", "v" }, "<leader><space>", "<cmd>lua vim.lsp.buf.code_action()<cr>", default_opts)
	-- lsp_zero.buffer_autoformat()

	-- local auto_save_format = vim.api.nvim_create_augroup("auto_save_format", { clear = true })
	-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	-- 	buffer = bufnr,
	-- 	group = auto_save_format,
	-- 	desc = "formats the buffer on save",
	-- 	callback = function()
	-- 		vim.lsp.buf.format()
	-- 	end,
	-- })

	if client.supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(true)
	end

	-- if client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
	-- 	pcall(vim.lsp.codelens.refresh)
	-- end
	--
	-- local codelens_cmds = vim.api.nvim_create_augroup("codelens_cmds", { clear = true })
	-- vim.api.nvim_create_autocmd("BufWritePost", {
	-- 	buffer = bufnr,
	-- 	group = codelens_cmds,
	-- 	desc = "refresh codelens",
	-- 	callback = function()
	-- 		if client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
	-- 			pcall(vim.lsp.codelens.refresh)
	-- 		end
	-- 	end,
	-- })
end)

