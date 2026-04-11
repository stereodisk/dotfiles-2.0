-- Treesitter (nueva API)
return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	config = function()
		local install = require("nvim-treesitter.install")

		install.prefer_git = true
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
