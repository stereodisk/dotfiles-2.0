return {
	"MeanderingProgrammer/render-markdown.nvim",
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		render_modes = { "n", "c", "t" },
		file_types = { "markdown", "Avante" },

		anti_conceal = {
			enabled = false,
		},

		completions = { lsp = { enabled = true } },
		latex = {
			enabled = true,
			render_modes = false,
			converter = "utftex",
			highlight = "RenderMarkdownMath",
			position = "center",
			top_pad = 0,
			bottom_pad = 0,
		},
	},
}
