local keys = require("keys")

return {
	"nvim-lua/plenary.nvim",
	"lewis6991/impatient.nvim",

	{
		"sachnr/base46",
		lazy = false,
		priority = 1000,
		config = function()
			require("base46").setup({
				term_colors = true,
				italics = true,
			})
			vim.cmd([[colorscheme one_dark]])
		end,
	},

	"nvim-tree/nvim-web-devicons",

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
		config = function()
			require("config.treesitter")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},

	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = function()
			require("config.lualine")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		"akinsho/toggleterm.nvim",
		config = true,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.indent-blankline")
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.gitsigns")
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.nvim-colorizer")
		end,
	},

	{
		"famiu/bufdelete.nvim",
		init = keys.bufdelete(),
	},

	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		priority = 1000,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-dap.nvim",
			"nvim-telescope/telescope-project.nvim",
			"benfowler/telescope-luasnip.nvim",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("config.telescope")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		init = keys.nvim_tree(),
		config = function()
			require("config.nvim-tree")
		end,
	},

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
		},
		config = function()
			require("config.cmp")
		end,
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

	{ "iamcco/markdown-preview.nvim", build = "npm install" },

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

	{
		"numToStr/Comment.nvim",
		cmd = "Comment",
		init = keys.comment,
		config = true,
	},

	{
		lazy = false,
		"goolord/alpha-nvim",
		config = function()
			require("config.alpha-nvim")
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = {
			{ "kevinhwang91/nvim-hlslens", config = require("config.hls-lens") },
		},
		config = function()
			require("config.scrollbar")
		end,
	},

	"LudoPinelli/comment-box.nvim",

	{
		"folke/which-key.nvim",
		keys = { "<leader>" },
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("config.which-key")
		end,
	},
}
