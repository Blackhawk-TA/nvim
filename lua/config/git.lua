require("telescope").load_extension("lazygit")
require("gitsigns").setup({
	current_line_blame = false,
	current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
	current_line_blame_opts = {
		delay = 100
	},
	sign_priority = 6,
	on_attach = function()
		local gs = package.loaded.gitsigns
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "<leader>gr", gs.reset_hunk)
		map("n", "<leader>gR", gs.reset_buffer)
		map("v", "<leader>gr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
		map("n", "<leader>gd", gs.diffthis)
		map("n", "<leader>gb", function() gs.blame_line { full = true } end)
		map("n", "<leader>gtb", gs.toggle_current_line_blame)
	end
})

-- lazygit bindings
vim.keymap.set("n", "<leader>go", "<cmd>lua require('telescope').extensions.lazygit.lazygit()<cr>")
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>")
vim.keymap.set("n", "<leader>gh", "<cmd>LazyGitFilter<cr>")
vim.keymap.set("n", "<leader>ghf", "<cmd>LazyGitFilterCurrentFile<cr>")
