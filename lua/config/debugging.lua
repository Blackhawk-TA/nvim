local dap = require("dap")
local dapui = require("dapui")

-- Toggle debug view
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
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
require('dap-go').setup() --TODO: Show output and debug view

-- Python debug adapter
dap.adapters.python = function(cb, config)
	if config.request == 'attach' then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or '127.0.0.1'
		cb({
			type = 'server',
			port = assert(port, '`connect.port` is required for a python `attach` configuration'),
			host = host,
			options = {
				source_filetype = 'python',
			},
		})
	else
		local cwd = vim.fn.getcwd()
		cb({
			type = 'executable',
			command = cwd .. '/.venv/bin/python',
			args = { '-m', 'debugpy.adapter' },
			options = {
				source_filetype = 'python',
			},
		})
	end
end

dap.configurations.python = {{
	-- The first three options are required by nvim-dap
	type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
	request = 'launch';
	name = "Launch file";

	-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
	program = "${file}"; -- This configuration will launch the current file if used.
	pythonPath = function()
		-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
		-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
		-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
		local cwd = vim.fn.getcwd()
		if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
			return cwd .. '/venv/bin/python'
		elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
			return cwd .. '/.venv/bin/python'
		else
			return '/usr/bin/python'
		end
	end;
}}

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

