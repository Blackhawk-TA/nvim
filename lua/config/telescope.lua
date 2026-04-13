local open_with_trouble = function(...)
	return require("trouble.sources.telescope").open(...)
end

require("telescope").setup({
	defaults = {
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
		},
		sorting_strategy = "ascending",
		file_ignore_patterns = { "vendor", "node_modules", "\\.git\\/", "\\.venv\\/", "\\.idea\\/" },
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-h>"] = "select_horizontal",
				["<C-s>"] = "select_vertical",
				["<C-z>"] = open_with_trouble,
			},
			n = { ["<C-z>"] = open_with_trouble },
		},
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
	},
})

require("dir-telescope").setup({
	hidden = true,
	no_ignore = false,
	show_preview = true,
})
require("telescope").load_extension("dir")
require("telescope").load_extension("ui-select")
