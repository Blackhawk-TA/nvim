local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Split window
keymap("n", "ss", ":split<CR><C-w>w", default_opts)
keymap("n", "sv", ":vsplit<CR><C-w>w", default_opts)

-- Move between windows
keymap("n", "sh", "<C-w>h", default_opts)
keymap("n", "sk", "<C-w>k", default_opts)
keymap("n", "sj", "<C-w>j", default_opts)
keymap("n", "sl", "<C-w>l", default_opts)

-- Resize window
keymap("n", "si", "<C-w>+", default_opts)
keymap("n", "su", "<C-w>-", default_opts)
keymap("n", "so", "<C-w><", default_opts)
keymap("n", "sp", "<C-w>>", default_opts)

-- Exit terminal mode on ESC
keymap("t", "<Esc>", "<C-\\><C-n>", default_opts)

-- Jump to latest edit
keymap("n", "<Tab>", "'.", default_opts)

-- Remove highlighting
keymap("n", "<Esc>", ":noh<CR>", default_opts)

-- LSP related
vim.keymap.set("n", "gd", "<cmd> lua vim.lsp.buf.definition()<cr>", default_opts)
vim.keymap.set("n", "<F2>", "<cmd> lua vim.lsp.buf.rename()<cr>", default_opts)
vim.keymap.set("n", "<F3>", "<cmd> lua vim.lsp.buf.format()<cr>", default_opts)
vim.keymap.set({ "n", "v" }, "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", default_opts)
vim.keymap.set("n", "<leader>d", "<cmd> lua vim.diagnostic.goto_next()<cr>", default_opts)
vim.keymap.set("n", "<leader>D", "<cmd> lua vim.diagnostic.goto_prev()<cr>", default_opts)
vim.keymap.set("n", "<leader>k", "<cmd> lua vim.diagnostic.open_float()<cr>", default_opts)
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>")
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("LspRestart")
	vim.print("Restarting LSP...")
end)
