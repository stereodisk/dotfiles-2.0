-- Treesitter (nueva API)
local install = require("nvim-treesitter.install")

install.prefer_git = true
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
