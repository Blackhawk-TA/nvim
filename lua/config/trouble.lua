local utils = require("utils.utils")
local hint_sign = utils.get_hint_char() .. " "

require("trouble").setup({
	signs = {
		error = "",
		warning = "",
		hint = hint_sign,
		information = "",
		other = "",
	},
})
