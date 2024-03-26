local dap = require("dap")
local dapui = require("dapui")
local utils = require("utils")

-- Toggle debug view
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	utils.store_current_buffer()
	dapui.open()
	if utils.is_neotree_open() then
		utils.neotree_open_before_debug = true
		vim.cmd("Neotree close")
	end
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	if utils.autoclose_debug_windows then
		utils.close_debugger()
	end
	utils.restore_current_buffer()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	if utils.autoclose_debug_windows then
		utils.close_debugger()
	end
	utils.restore_current_buffer()
end

-- C/C++/Rust debug adapter
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = utils.get_mason_binary("codelldb"),
		args = { "--port", "${port}" },
	},
}
dap.configurations.c = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- Go debug adapter
require("dap-go").setup()

-- Python debug adapter
local python_path = utils.get_python_path()
require("dap-python").setup(python_path)

-- Debugging keybindings
vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
vim.keymap.set("n", "<F6>", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>") -- Set Breakpoint condition

vim.keymap.set("n", "<F21>", "<cmd>lua require('dap').run_last()<cr>")                                            -- Re-run debugger, equals Shift + F9
vim.keymap.set("n", "<F33>", "<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<cr>")              -- Stop debugging, equals Control + F9
vim.keymap.set("n", "<F9>", "<cmd>lua require('utils').start_debugger(true)<cr>")
vim.keymap.set("n", "<F10>", "<cmd>lua require('utils').start_debugger(false)<cr>")
vim.keymap.set("n", "<F22>", "<cmd>lua require('utils').close_debugger()<cr>") -- Equals Shift + F10

vim.keymap.set("n", "<F7>", "<cmd>lua require('dap').step_into()<cr>")
vim.keymap.set("n", "<F19>", "<cmd>lua require('dap').step_out()<cr>") -- Equals Shift + F7
vim.keymap.set("n", "<F8>", "<cmd>lua require('dap').step_over()<cr>")

vim.keymap.set("n", "<F12>", "<cmd>lua require('dapui').eval()<cr>")

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
