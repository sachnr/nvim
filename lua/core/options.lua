local opt = vim.opt
local g = vim.g

-- base46 theme
g.theme = "gruvbox" -- ayu-dark, everforest, gruvbox, nord, onedark, tokyonight, gruvbox_material, rxyhn
g.mapleader = " "

opt.title = true -- let Vim set the title of the windowlet Vim set the title of the window
opt.clipboard = "unnamedplus" -- allow neovim to access system clipboard
opt.cursorline = true -- highlights the current line
opt.showmode = false -- message on status line to show current mode
opt.smartcase = true -- no ignore case when pattern has uppercase
opt.ignorecase = true -- ignore case for completions
opt.shortmess:append("sI") -- list of flags, reduce length of messages
opt.laststatus = 3 --tells when last window has status lines
opt.mouse = "a" -- allows use of mouse
opt.fillchars = { eob = " " } -- characters to use for displaying special items
opt.signcolumn = "yes" -- when and how to display the sign column
opt.splitbelow = true -- new window from split is below the current one
opt.splitright = true -- new window is put right of the current one
opt.termguicolors = true
opt.timeoutlen = 400 -- time out time in milliseconds
opt.updatetime = 250 -- after this many milliseconds flush swap file
opt.writebackup = false -- make a backup before overwriting a file
opt.wrap = true -- long lines wrap and continue on the next line
opt.fileencoding = "utf-8" -- encoding
opt.undofile = true -- save undo information in a file
opt.undodir = vim.fn.stdpath("data") .. "/undofile" -- where to store undo files

-- Indenting
opt.expandtab = true -- converts tabs to spaces
opt.autoindent = true -- take indent for new line from previous line
opt.shiftwidth = 2 -- no of spaces for each indent
opt.smartindent = true -- smart autoindenting for C programs
opt.tabstop = 2 -- insert 2 spaces for tab
opt.softtabstop = 2 -- number of spaces that <Tab> uses while editing

-- line numbers
opt.number = true -- print the line number in front of each line
opt.numberwidth = 2 -- number of columns used for the line number
opt.ruler = false -- show cursor line and column in the status line
opt.relativenumber = true --show relative line number in front of each line

-- disable some builtin vim plugins
local default_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(default_plugins) do
	g["loaded_" .. plugin] = 1
end
