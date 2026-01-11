-- @vim.opt Options

-- indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- split
vim.opt.splitbelow = true
vim.opt.splitright = true

-- wrap
vim.opt.wrap = false

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- scrolling
vim.opt.scrolloff = 999

-- v-block
vim.opt.virtualedit = "block"

-- replace split
vim.opt.inccommand = "split"

-- cmdline
vim.opt.ignorecase = true
vim.opt.signcolumn = "yes"

-- colorscheme
vim.cmd.colorscheme("oldworld")
