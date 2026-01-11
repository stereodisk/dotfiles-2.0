return {
	"chrisgrieser/nvim-rip-substitute",
	cmd = "RipSubstitute",
	keys = {
		{
			"<leader>fs",
			function()
				require("rip-substitute").sub()
			end,
			mode = { "n", "x" },
			desc = " rip substitute",
		},
	},
	config = function()
		require("rip-substitute").setup({
			popupWin = {
				title = " Substitute",
				hideKeymapHints = true,
			},
		})
	end,
}
