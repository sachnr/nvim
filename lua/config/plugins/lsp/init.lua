return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.plugins.lsp.setup")
		end,
		dependencies = {
			{
				"folke/neodev.nvim",
				"folke/neoconf.nvim",
			},
		},
	},

	-- {
	-- 	"jose-elias-alvarez/null-ls.nvim",
	-- 	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	-- 	config = function()
	-- 		require("config.null-ls")
	-- 	end,
	-- },

	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			require("config.plugins.configs.mason")
		end,
	},
}
