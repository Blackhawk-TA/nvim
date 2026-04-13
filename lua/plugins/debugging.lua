return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
			"mfussenegger/nvim-dap-python",
		},
		keys = {
			{ "<F5>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
			{ "<F6>", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
			{ "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
			{ "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
			{ "<F9>", function() require("utils.debugger").start(true) end, desc = "Start Debugger" },
			{ "<F10>", function() require("utils.debugger").start(false) end, desc = "Start Debugger (no build)" },
			{ "<F12>", function() require("dapui").eval() end, desc = "Eval Expression" },
			-- Step out, equals Shift + F7
			{ "<F19>", function() require("dap").step_out() end, desc = "Step Out" },
			{ "<S-F7>", function() require("dap").step_out() end, desc = "Step Out" },
			-- Re-run debugger, equals Shift + F9
			{ "<F21>", function() require("utils.debugger").run_last() end, desc = "Restart/Run Last" },
			{ "<S-F9>", function() require("utils.debugger").run_last() end, desc = "Restart/Run Last" },
			-- Close debugger, equals Shift + F10
			{ "<F22>", function() require("utils.debugger").close() end, desc = "Close Debugger" },
			{ "<S-F10>", function() require("utils.debugger").close() end, desc = "Close Debugger" },
			-- Stop debugging, equals Control + F9
			{ "<F33>", function() require("dap").disconnect({ terminateDebuggee = true }) end, desc = "Stop Debugger" },
			{ "<C-F9>", function() require("dap").disconnect({ terminateDebuggee = true }) end, desc = "Stop Debugger" },
		},
		config = function()
			require("config/debugging")
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
