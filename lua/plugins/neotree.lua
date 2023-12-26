return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		--"3rd/image.nvim",
	},
	opts = {
		close_if_last_window = true,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		window = {
			mappings = {
				["s"] = "noop",
				["<C-s>"] = "open_vsplit",
				["<C-t>"] = "open_tabnew",
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
				hide_dotfiles = false,
				hide_gitignored = false,
				respect_gitignore = true,
			},
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true, -- use OS to detect file changes
		},
		git_status = {
			symbols = {
				-- Change type
				added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted   = "✖", -- this can only be used in the git_status source
				renamed   = "󰁕", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored   = "",
				unstaged  = "󰄱",
				staged    = "",
				conflict  = "",
			}
		}
	}
}
