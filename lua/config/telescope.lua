local trouble = require("trouble.sources.telescope")
require("telescope").setup {
	defaults = {
		file_ignore_patterns = { "node_modules", "\\.git\\/", "\\.venv\\/", "\\.idea\\/" },
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "select_horizontal",
				["<C-s>"] = "select_vertical",
				["<C-z>"] = trouble.open
			},
			n = { ["<C-z>"] = trouble.open },
		}
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	}
}

require("dir-telescope").setup({
	hidden = true,
	no_ignore = false,
	show_preview = true,
})
require("telescope").load_extension("dir")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.keymap.set("n", "<leader>fd", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
