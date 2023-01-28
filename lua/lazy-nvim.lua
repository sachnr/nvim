local plugins = require("plugins")
local utils = require("utils")
local bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
		border = utils.border("FloatBorder"),
	},
	custom_keys = {
		["<localleader>l"] = false,
		["<localleader>t"] = false,
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
			},
		},
	},
}

require("lazy").setup(plugins, opts)

if bootstrap then
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyDone",
		callback = function()
			vim.cmd("bw | silent! MasonInstallAll") -- close packer window
			vim.cmd("Lazy load nvim-treesitter")
		end,
	})
end
