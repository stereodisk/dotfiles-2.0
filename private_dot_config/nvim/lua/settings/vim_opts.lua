-- @Options: vim.opt

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- scrolling
vim.opt.scrolloff = 999

-- v-block
vim.opt.virtualedit = "block"

-- replace split
vim.opt.inccommand = "split"

-- autoread
vim.o.autoread = true

-- cmdline
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"

-- inlay_hint
vim.lsp.inlay_hint.enable(true)

-- undofile
vim.opt.undofile = true
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir

-- undotree
vim.cmd("packadd nvim.undotree")

-- ui2
require("vim._core.ui2").enable({ enable = true })
