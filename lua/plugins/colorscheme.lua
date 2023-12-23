return {
	"navarasu/onedark.nvim",
	priority = 1000, -- make sure it loads before all other plugins
	config = function() 
		require("onedark").setup {
		    style = "cool",
		    transparent = false,
		}
		require("onedark").load()
	end,
}

