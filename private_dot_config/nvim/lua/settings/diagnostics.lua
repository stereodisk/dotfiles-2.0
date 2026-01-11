-- @Langs: @Diagnostics

vim.diagnostic.config({
	signs = {
		numhl = { "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint" },
		text = { " ", " ", "󰋼 ", "󰌶" },
		texthl = { "DiagnosticSignError", "DiagnosticSignWarn", "DiagnosticSignInfo", "DiagnosticSignHint" },
	},

	float = {
		source = true,
		border = "rounded",
	},

	underline = true,
	virtual_text = true,
	severity_sort = true,
	update_in_insert = true,
})
