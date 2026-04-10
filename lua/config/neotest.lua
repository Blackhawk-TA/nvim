require("neotest").setup({
	adapters = {
		require("neotest-python")({
			dap = { justMyCode = false },
		}),
		require("neotest-golang")({
			warn_test_name_dupes = false, -- prevent warning spam when using parameterized tests
			runner = "gotestsum",
		}),
	},
})
