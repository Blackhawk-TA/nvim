require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		cpp = { require("formatter.filetypes.cpp").clangformat },
		go = { require("formatter.filetypes.go").gofmt },
		json = { require("formatter.filetypes.json").prettier }, -- editorconfig support
		lua = { require("formatter.filetypes.lua").stylua }, -- editorconfig support
		python = { require("formatter.filetypes.python").autoflake },
	},
})

vim.keymap.set("n", "<leader>cf", "<Cmd>FormatWrite<CR>")

