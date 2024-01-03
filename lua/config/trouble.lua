require("trouble").setup({
signs = {
     error = "",
      warning = "",
      hint = "󰌵",
      information = "",
      other = "",
    },
})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
vim.keymap.set("n", "<leader>xf", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>")
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle lsp_definitions<cr>")
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")

