vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.inccommand = "nosplit"
vim.opt.mouse = "a"
vim.opt.title = false
-- opt.guicursor = { "n-c-v:block-nCursor" }

vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true

vim.opt.cursorline = true

vim.opt.showcmd = true
-- opt.showmatch = true
vim.opt.showmode = false

vim.opt.laststatus = 3
vim.opt.fillchars = { stl = " ", eob = " " }
vim.opt.signcolumn = "yes"
vim.opt.writebackup = false
vim.opt.fileencoding = "utf-8"
vim.opt.swapfile = false

-- window
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.equalalways = false

-- scroll
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- undo
vim.opt.undofile = true

-- Tabs/indent
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.joinspaces = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.showbreak = string.rep(" ", 3)
vim.opt.linebreak = true
-- fold
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 0
vim.opt.modelines = 1
-- vim.opt.conceallevel = 2

vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true

vim.opt.inccommand = "split"

vim.opt.timeout = true
vim.opt.updatetime = 600
vim.opt.timeoutlen = 400
