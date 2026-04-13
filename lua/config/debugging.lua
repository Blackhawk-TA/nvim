local dap = require("dap")
local dapui = require("dapui")

local debugger = require("utils.debugger")
local system = require("utils.system")
local utils = require("utils.utils")

-- Toggle debug view
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	debugger.store_current_buffer()
	dapui.open()
	if utils.is_neotree_open() then
		debugger.neotree_open_before_debug = true
		vim.cmd("Neotree close")
	end
	if utils.is_terminal_open() then
		debugger.terminal_open_before_debug = true
		vim.cmd("ToggleTermToggleAll")
	end
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	if debugger.autoclose_debug_windows then
		debugger.close()
	end
	debugger.restore_current_buffer()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	if debugger.autoclose_debug_windows then
		debugger.closer()
	end
	debugger.restore_current_buffer()
end

-- C/C++/Rust debug adapter
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = system.get_mason_binary("codelldb"),
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
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- Go debug adapter
require("dap-go").setup()

-- Python debug adapter
local python_path = system.get_python_path()
require("dap-python").setup(python_path)

-- Breakpoints appearance
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#ef5f6b", bg = "#2d3343" })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#2d3343" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#2d3343" })

vim.fn.sign_define("DapBreakpoint", {
	text = "●",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointCondition", {
	text = "○",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapBreakpointRejected", {
	text = "",
	texthl = "DapBreakpoint",
	linehl = "DapBreakpoint",
	numhl = "DapBreakpoint",
})
vim.fn.sign_define("DapLogPoint", {
	text = "",
	texthl = "DapLogPoint",
	linehl = "DapLogPoint",
	numhl = "DapLogPoint",
})
vim.fn.sign_define("DapStopped", {
	text = "",
	texthl = "DapStopped",
	linehl = "DapStopped",
	numhl = "DapStopped",
})
