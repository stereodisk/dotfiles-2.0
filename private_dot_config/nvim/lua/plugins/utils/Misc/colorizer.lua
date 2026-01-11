return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			"*",
			"TelescopePrompt",
			"!alpha",
			"!lazy",
			"!Outline",
		})
	end,
}
