return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.lsp")
		end,
		dependencies = {
			{
				"folke/neodev.nvim",
				config = function()
					require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })
				end,
			},
		},
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
			require("config.lsp.cmp")
		end,
	},

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
				"theHamsta/nvim-dap-virtual-text",
				config = true,
			},
			{ "jbyuki/one-small-step-for-vimkind" },
			{
				"mxsdev/nvim-dap-vscode-js",
				config = function()
					require("dap-vscode-js").setup({
						debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
						adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
					})
				end,
			},
		},
	},

	{
		"rcarriga/nvim-dap-ui",
		config = function()
			require("config.nvim-dap.dapui")
		end,
	},

	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npm run compile",
	},

	"mfussenegger/nvim-jdtls",
}
