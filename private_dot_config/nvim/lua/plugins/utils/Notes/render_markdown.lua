require("render-markdown").setup({
	render_modes = { "n", "c", "t" },
	file_types = { "markdown", "Avante" },

	anti_conceal = {
		enabled = false,
	},

	completions = { lsp = { enabled = true } },
})
