-- @UI
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/shaunsingh/nord.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },

	-- @LSP
	-- completions LuaSnip
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" },

	-- mason
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- conform formatter
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- snippets
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = "v2.5.0" },

	-- @UTILS
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },

	-- Parser & Search
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/chrisgrieser/nvim-rip-substitute" },
})

require("manager.commands")

-- @REQUIRES
-- UI
require("plugins.UI.gitsigns")
require("plugins.UI.lualine")
require("plugins.UI.nord")

-- LSP & Snippets
require("plugins.lsp.LSP_Engine.mason")
require("plugins.lsp.LSP_Engine.conform")
require("plugins.lsp.Completions_Engine.nvim_cmp")

-- Utils
require("plugins.utils.Misc.icons")
require("plugins.utils.Misc.autopairs")
require("plugins.utils.Misc.colorizer")
require("plugins.utils.Notify.fidget")
require("plugins.utils.Notify.telescope_select")
require("plugins.utils.Parser.treesitter")
require("plugins.utils.Notes.render_markdown")
require("plugins.utils.Search.oil")
require("plugins.utils.Search.rip-substitute")
