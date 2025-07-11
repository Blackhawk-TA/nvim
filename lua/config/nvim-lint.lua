require("lint").linters_by_ft = {
	c = {
		"cpplint",
	},
	cmake = {
		"cmakelint",
	},
	cpp = {
		"cpplint",
	},
	editorconfig = {
		"editorconfig-checker",
	},
	go = {
		"golangcilint",
	},
	json = {
		"jsonlint",
	},
	lua = {
		"luacheck",
	},
	markdown = {
		"markdownlint",
	},
	python = {
		"mypy",
	},
	yaml = {},
}

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
	callback = function()
		require("lint").try_lint()
		require("lint").try_lint("cspell") -- Run cspell for all files
	end,
})
