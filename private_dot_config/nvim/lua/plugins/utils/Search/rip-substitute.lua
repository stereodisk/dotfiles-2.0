vim.keymap.set({ "n", "x" }, "<leader>fs", function()
	require("rip-substitute").sub()
end, { desc = " rip substitute" })

require("rip-substitute").setup({
	popupWin = {
		title = " Substitute",
		hideKeymapHints = true,
	},
})
