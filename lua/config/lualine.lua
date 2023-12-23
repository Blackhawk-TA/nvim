local function get_time()
	return " " .. os.date("%H:%M") .. " "
end

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
	},
	sections = {
		lualine_a = {"mode"},
		lualine_b = {"branch", "diff", "diagnostics"},
		lualine_c = {"filename"},
		lualine_x = {"encoding", "fileformat", "filetype"},
		lualine_y = {"progress", "location" },
		lualine_z = { get_time },
	}
})

