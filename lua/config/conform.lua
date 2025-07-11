local conform = require("conform")

conform.setup({
	log_level = vim.log.levels.WARN,
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	-- Go formatter is handled by LSP
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		javascript = { "prettier" },
		json = { "prettier" },
		typescript = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		python = { "autoflake", "black" },
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
