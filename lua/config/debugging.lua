local dap = require("dap")
local dapui = require("dapui")
local utils = require("utils")
require("dap.ext.vscode").load_launchjs(nil, {})

-- Toggle debug view
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
	if utils.is_neotree_open() then
		utils.neotree_open_before_debug = true
		vim.cmd("Neotree close")
	end
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
	if not utils.is_neotree_open() and utils.neotree_open_before_debug == true then
		utils.neotree_open_before_debug = false
		vim.cmd("Neotree show")
	end
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
	if not utils.is_neotree_open() and utils.neotree_open_before_debug == true then
		utils.neotree_open_before_debug = false
		vim.cmd("Neotree show")
	end
end

--TODO: Eval expression + floating elements + debug setup for python, node, c/c++, go

-- C/C++/Rust debug adapter
dap.adapters.gdb = {
	type = "executable",
	command = "gdb",
	args = { "-i", "dap" }
}
dap.configurations.c = {{
	name = "Launch",
	type = "gdb",
	request = "launch",
	program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = "${workspaceFolder}",
}}
dap.configurations.cpp = {{
	name = "Launch",
	type = "gdb",
	request = "launch",
	program = function()
		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	end,
	cwd = "${workspaceFolder}",
} }

-- Go debug adapter
require("dap-go").setup() --TODO: Show output and debug view

-- Python debug adapter
local python_path = utils.get_python_path()
require("dap-python").setup(python_path) -- FIX: .vscode/launch.json support

-- Debugging keybindings
vim.keymap.set("n", "<F5>", "<cmd>lua require('dap').toggle_breakpoint()<cr>")
vim.keymap.set("n", "<F6>", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>") -- Set Breakpoint condition

vim.keymap.set("n", "<S-F9>", "<cmd>lua require('dap').run_last()<cr>") -- Re-run debugger
vim.keymap.set("n", "<C-F9>", "<cmd>lua require('dap').disconnect({ terminateDebuggee = true })<<cr>") -- Stop debugging
vim.keymap.set("n", "<F9>", "<cmd>lua require('utils').start_debugger()<cr>")

vim.keymap.set("n", "<F7>", "<cmd>lua require('dap').step_into()<cr>")
vim.keymap.set("n", "<F8>", "<cmd>lua require('dap').step_over()<cr>")
vim.keymap.set("n", "<S-F8>", "<cmd>lua require('dap').step_out()<cr>")

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

