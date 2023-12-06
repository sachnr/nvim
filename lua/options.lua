local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

opt.inccommand = "nosplit"
opt.mouse = "a" -- allows use of mouse
opt.title = false -- let Vim set the title of the windowlet Vim set the title of the window
-- opt.guicursor = { "n-c-v:block-nCursor" }

opt.clipboard = "unnamedplus" -- allow neovim to access system clipboard
opt.termguicolors = true -- Enables 24-bit RGB color in the TUI

opt.cursorline = true -- highlights the current line

opt.showcmd = true -- Show (partial) command in the last line of the screen
-- opt.showmatch = true -- show matching brackets when text indicator is over them
opt.showmode = false -- message on status line to show current mode

opt.shortmess:append("sI") -- list of flags, reduce length of messages
opt.laststatus = 3 --tells when last window has status lines
opt.fillchars = { stl = " ", eob = " " } -- characters to use for displaying special items
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.writebackup = false -- make a backup before overwriting a file
opt.fileencoding = "utf-8" -- encoding
opt.swapfile = false -- whether to use a swapfile for a buffer

-- window
opt.splitbelow = true -- new window from split is below the current one
opt.splitright = true -- new window is put right of the current one
opt.equalalways = false -- resize automatically

-- scroll
opt.scrolloff = 4 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`

-- search
opt.incsearch = true -- Makes search act like search in modern browsers
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ... unless there is a capital letter in the query

-- undo
opt.undofile = true -- save undo information in a file

-- Tabs/indent
opt.autoindent = true -- take indent for new line from previous line
opt.tabstop = 4 -- insert 4 spaces for tab
opt.softtabstop = 4 -- number of spaces that <Tab> uses while editing
opt.shiftwidth = 4 -- no of spaces for each indent
opt.expandtab = true --insert mode: uses spaces for <Tab>

opt.joinspaces = false
-- text wrap
opt.wrap = true -- long lines wrap and continue on the next line
opt.breakindent = true -- Every wrapped line will continue visually indented
opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true --wrap long lines at a character in 'breakat' rather than at the last character that fits on the screen
-- fold
opt.foldlevelstart = 99
opt.foldmethod = "marker"
opt.foldlevel = 0
opt.modelines = 1
opt.conceallevel = 2

opt.belloff = "all"

-- line numbers
opt.number = true -- print the line number in front of each line
opt.numberwidth = 3 -- number of columns used for the line number
opt.relativenumber = true --show relative line number in front of each line

opt.inccommand = "split"

vim.o.timeout = true
opt.updatetime = 600 -- after this many milliseconds flush swap file, Make updates happen faster
opt.timeoutlen = 400 -- keypress time out time in milliseconds
