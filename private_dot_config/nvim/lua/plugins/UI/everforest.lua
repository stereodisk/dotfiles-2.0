require("lazy").setup({
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		local everforest = require("everforest")
		everforest.setup({
			background = "medium",
		})
		everforest.load()
	end,
})
