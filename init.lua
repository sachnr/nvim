require("options")
local bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins = require("config.plugins")

if not vim.loop.fs_stat(lazypath) then
	bootstrap = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	defaults = {
		lazy = true, -- should plugins be lazy-loaded?
	},
	ui = {
		border = "single",
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"syntax",
				"tutor",
				"rplugin",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
			},
		},
	},
}

require("keys").defaults()
require("lazy").setup("config.plugins", opts)

if bootstrap then
	vim.cmd("bw | silent! MasonInstallAll")
	vim.cmd("Lazy load nvim-treesitter")
end
