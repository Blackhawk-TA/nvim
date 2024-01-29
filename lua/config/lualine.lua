local function get_info()
	local reg_recording = vim.fn.reg_recording()
	if reg_recording == "" then
		return " " .. os.date("%H:%M") .. " "
	else
		return "Recording: " .. reg_recording
	end
end

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		symbols = { error = " ", warn = " ", info = " ", hint = " " },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress", "location" },
		lualine_z = { get_info },
	}
})
