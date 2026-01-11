-- @Langs: @LSP

--@Ensure tools
local needed_servers = {
	"pylsp",
	"lua_ls",
	"gopls",
	"clangd",
	"jdtls",
	"typescript-language-server",
	"superhtml",
	"cssls",
	"ruby-lsp",
}

local needed_formatters = {
	"ruff",
	"stylua",
	"gofumpt",
	"goimports",
	"golines",
	"clang-format",
	"prettier",
}
require("mason-tool-installer").setup({ ensure_installed = vim.list_extend(needed_formatters, needed_servers) })

--@LSP server configs
local servers_config = {
	-- @python
	pylsp = {
		cmd = { "pylsp" },
		filetypes = { "python" },

		settings = {
			pylsp = {
				plugins = {
					pycodestyle = { enabled = false },
					pyflakes = { enabled = false },
					mccabe = { enabled = false },

					ruff = {
						enabled = true,
						extendSelect = { "I" },
						lineLength = 88,
					},

					jedi_completion = { enabled = true },
					jedi_hover = { enabled = true },
					jedi_references = { enabled = true },
					jedi_signature_help = { enabled = true },
					jedi_symbols = { enabled = true },
				},
			},
		},
	},

	-- @lua
	lua_ls = {
		on_init = function(client)
			if client.workspace_folders then
				local path = client.workspace_folders[1].name
				if
					path ~= vim.fn.stdpath("config")
					and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
				then
					return
				end
			end

			client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
				runtime = {
					version = "LuaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					},
				},
				workspace = {
					checkThirdParty = false,
					library = {
						--vim.env.VIMRUNTIME,
						"${3rd}/love2d/library",
					},
				},
			})
		end,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "love" },
				},
			},
		},
	},

	-- @go
	gopls = {
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },

		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = {
					unusedparams = true,
				},
			},
		},
	},

	-- @gleam
	gleam = {},

	-- @ruby
	ruby_lsp = {
		cmd = { "ruby-lsp" },
		filetypes = { "ruby" },
		init_options = {
			formatter = "standard",
			linters = { "standard" },
		},
	},

	--@html
	superhtml = {
		cmd = { "superhtml", "lsp" },
		root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
	},

	--@css
	cssls = {
		init_options = {
			provideFormatter = true,
		},

		settings = {
			css = {
				validate = true,
			},
			less = {
				validate = true,
			},
			scss = {
				validate = true,
			},
		},
	},
}

local capabilities = vim.tbl_deep_extend(
	"force",
	vim.lsp.protocol.make_client_capabilities(),
	require("cmp_nvim_lsp").default_capabilities(),
	{
		general = {
			positionEncodings = { "utf-8", "utf-16" },
		},
	}
)

local servers = vim.list_extend(
	require("mason-lspconfig").get_installed_servers(),
	{ "gleam" } -- not in Mason
)

-- Enable servers (with or without pre-config)
for _, server in ipairs(servers) do
	local config = servers_config[server] or {}
	config.capabilities = capabilities

	vim.lsp.config(server, config)
	vim.lsp.enable(server)
end
vim.lsp.inlay_hint.enable(true)
