return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},
		keys = function ()
			local dap = require("dap")
			local dapui = require("dapui")
			local debugger = require("utils.debugger")

			return {
				{ "<F5>", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
				{ "<F6>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
				{ "<F7>", dap.step_into, desc = "Step Into" },
				{ "<F8>", dap.step_over, desc = "Step Over" },
				{ "<F9>", function() debugger.start(true) end, desc = "Start Debugger" },
				{ "<F10>", function() debugger.start(false) end, desc = "Start Debugger (no build)" },
				{ "<F12>", dapui.eval, desc = "Eval Expression" },
				-- Step out, equals Shift + F7
				{ "<F19>", dap.step_out, desc = "Step Out" },
				{ "<S-F7>", dap.step_out, desc = "Step Out" },
				-- Re-run debugger, equals Shift + F9
				{ "<F21>", debugger.run_last, desc = "Restart/Run Last" },
				{ "<S-F9>", debugger.run_last, desc = "Restart/Run Last" },
				-- Close debugger, equals Shift + F10
				{ "<F22>", debugger.close, desc = "Close Debugger" },
				{ "<S-F10>", debugger.close, desc = "Close Debugger" },
				-- Stop debugging, equals Control + F9
				{ "<F33>", function() dap.disconnect({ terminateDebuggee = true }) end, desc = "Stop Debugger" },
				{ "<C-F9>", function() dap.disconnect({ terminateDebuggee = true }) end, desc = "Stop Debugger" },
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
	{ "leoluz/nvim-dap-go", lazy = true },
	{ "mfussenegger/nvim-dap-python", lazy = true },
}
