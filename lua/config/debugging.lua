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
		cwd = "${workspaceFolder}",
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

-- Helper function to restart an active debugging session
local function restart_or_run_last()
	-- On no active debug session, rerun last one
	if not dap.session() then
		dap.run_last()
		return
	end

	-- On active debug session, restart it
	dap.terminate({}, {}, function()
		-- add 150ms delay to give the adapter time to fully exit before starting again
		vim.defer_fn(function()
			dap.run_last()
		end, 150)
	end)
end

-- Debugging keybindings
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<F8>", dap.step_over)
vim.keymap.set("n", "<F12>", dapui.eval)
vim.keymap.set("n", "<F5>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F6>", function()
	-- Set Breakpoint condition
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

vim.keymap.set("n", "<F9>", function()
	utils.start_debugger(true)
end)
vim.keymap.set("n", "<F10>", function()
	utils.start_debugger(false)
end)

-- There are two ways F-Keys are displayed when modifier keys like Shift or Control are used
-- Therefore both definitions have to be included for each command that uses modifier keys

-- Re-run debugger, equals Shift + F9
vim.keymap.set("n", "<F21>", restart_or_run_last)
vim.keymap.set("n", "<S-F9>", restart_or_run_last)

-- Stop debugging, equals Control + F9
vim.keymap.set("n", "<F33>", function()
	dap.disconnect({ terminateDebuggee = true })
end)
vim.keymap.set("n", "<C-F9>", function()
	dap.disconnect({ terminateDebuggee = true })
end)

-- Close debugger, equals Shift + F10
vim.keymap.set("n", "<F22>", utils.close_debugger)
vim.keymap.set("n", "<S-F10>", utils.close_debugger)

-- Set up of function, equals Shift + F7
vim.keymap.set("n", "<F19>", dap.step_out)
vim.keymap.set("n", "<S-F7>", dap.step_out)

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
