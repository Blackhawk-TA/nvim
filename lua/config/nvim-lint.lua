require("lint").linters_by_ft = {
	c = {
		"cpplint",
		"cspell"
	},
	cmake = {
		"cmakelint",
		"cspell"
	},
	cpp = {
		"cpplint",
		"cspell"
	},
	go = {
		"golangcilint",
		"cspell"
	},
	json = {
		"jsonlint",
		"cspell"
	},
	lua = {
		"luacheck",
		"cspell"
	},
	markdown = {
		"markdownlint",
		"cspell"
	},
	python = {
		"mypy",
		"cspell"
	},
	yaml = {
		"yamllint",
		"cspell"
	},
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
	end,
})

