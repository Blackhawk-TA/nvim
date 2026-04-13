local keys = {
	{ "<leader>ta", ":ToggleTermToggleAll<cr>", desc = "Toggle All Terminals" },
	{ "<leader>tt", ":ToggleTerm<cr>", desc = "Toggle Terminal" },
	{ "<leader>tf", ":9ToggleTerm direction=float<cr>", desc = "Float Terminal" },
}

for i = 1, 8 do
	table.insert(keys, {
		"<leader>t" .. i,
		":" .. i .. "ToggleTerm direction=horizontal name=Term" .. i .. "<cr>",
		desc = "Terminal " .. i,
	})
end

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "ToggleTermToggleAll" },
	keys = keys,
	config = function()
		require("config/toggleterm")
	end,
}
