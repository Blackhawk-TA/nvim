vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
vim.keymap.set("n", "<F6>", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>") -- Set Breakpoint condition

vim.keymap.set("n", "<S-F9>", "<cmd>lua require('dap').run_last()<cr>") -- Re-run debugger
vim.keymap.set("n", "<C-F9>", "<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<<cr>") -- Stop debugging

vim.keymap.set("n", "<F7>", "<cmd>lua require('dap').step_into()<cr>")
vim.keymap.set("n", "<F8>", "<cmd>lua require('dap').step_over()<cr>")
vim.keymap.set("n", "<S-F8>", "<cmd>lua require('dap').step_out()<cr>")
vim.keymap.set("n", "<F9>", "<cmd>lua require('dap').continue()<cr>")

-- Breakpoints appearance
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ef5f6b", bg = "#2d3343" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#2d3343" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#2d3343" })

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint"
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = "○",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint"
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint"
})
vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLogPoint",
	linehl = "DapLogPoint",
	numhl = "DapLogPoint"
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStopped",
	linehl = "DapStopped",
	numhl = "DapStopped"
})

