require("options")
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
		border = "single",
	},
	change_detection = {
		enabled = false,
		notify = false,
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
require("lazy").setup("plugins", opts)
require("statusline")

vim.cmd.colorscheme("kanagawa-wave")

local CloseAllFloatingWindows = function()
	local closed_windows = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- is_floating_window?
			vim.api.nvim_win_close(win, false) -- do not force
			table.insert(closed_windows, win)
		end
	end
	print(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end

vim.api.nvim_create_user_command("ClearFloats", function()
	CloseAllFloatingWindows()
end, { nargs = 0 })

vim.api.nvim_create_user_command("GetBufType", function()
	local buftype = vim.bo.buftype
	local filetype = vim.bo.filetype
	print("buftype: " .. buftype .. " | filetype: " .. filetype)
end, { nargs = 0 })

local toggle_inlay_hints = function()
	local enabled = vim.lsp.inlay_hint.is_enabled(0)
	if enabled then
		vim.lsp.inlay_hint.enable(0, false)
	else
		vim.lsp.inlay_hint.enable(0, true)
	end
end

vim.api.nvim_create_user_command("InlayHintToggle", function()
	toggle_inlay_hints()
end, { nargs = 0 })

vim.keymap.set("n", "\\", function()
	toggle_inlay_hints()
end, { silent = true, noremap = true, desc = "Toggle Inlay Hints" })

if bootstrap then
	vim.cmd("bw | silent! MasonInstallAll")
	vim.cmd("Lazy load nvim-treesitter")
end
