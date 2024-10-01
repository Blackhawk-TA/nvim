require("devcontainer").setup({})

vim.keymap.set("n", "<leader>dd", "<Cmd>DevcontainerStart<CR>")
vim.keymap.set("n", "<leader>ds", "<Cmd>DevcontainerStopAll<CR>")
vim.keymap.set("n", "<leader>dl", "<Cmd>DevcontainerLogs<CR>")
vim.keymap.set("n", "<leader>dr", "<Cmd>DevcontainerRemoveAll<CR>")
