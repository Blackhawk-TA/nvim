require("telescope").load_extension("lazygit")

-- lazygit bindings
vim.keymap.set("n", "<leader>gr", "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")
vim.keymap.set("n", "<leader>gh", "<cmd>LazyGitFilter<cr>")
vim.keymap.set("n", "<leader>ghf", "<cmd>LazyGitFilterCurrentFile<cr>")

-- vim-fugitive bindings
vim.keymap.set("n", "<leader>gc", ":Gvdiffsplit<cr>")
vim.keymap.set("n", "<leader>gb", ":Git blame<cr>")
vim.keymap.set("n", "<leader>gm", ":Git mergetool<cr>")

