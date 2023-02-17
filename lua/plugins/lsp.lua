return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.lsp")
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			"windwp/nvim-autopairs",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("config.cmp")
		end,
	},

	{ "folke/neodev.nvim", config = true },

	{
		"mhartington/formatter.nvim",
		keys = {
			{ "<leader>f", "<cmd>Format<cr>", desc = "Format" },
		},
		config = function()
			require("config.formatter")
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "TroubleRefresh" },
		config = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
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
			require("config.mason")
		end,
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				config = function()
					require("config.nvim-dap.dapui")
				end,
			},
			{ "jbyuki/one-small-step-for-vimkind" },
		},
		config = function()
			require("config.nvim-dap.dap")
		end,
	},

	"mfussenegger/nvim-jdtls",
}
