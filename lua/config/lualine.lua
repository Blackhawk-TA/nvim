local utils = require("utils.utils")

local function get_info()
	local reg_recording = vim.fn.reg_recording()
	if reg_recording == "" then
		return " " .. os.date("%H:%M") .. " "
	else
		return "Recording: " .. reg_recording
	end
end

local hint_sign = utils.get_hint_char() .. " "

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		symbols = { error = " ", warn = " ", info = " ", hint = hint_sign },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress", "location" },
		lualine_z = { get_info },
	},
})
