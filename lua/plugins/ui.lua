local keys = require("keys")

return {
	-- colorscheme
	{
		"sachnr/base46",
		lazy = false,
		priority = 1000,
		config = function()
			require("base46").setup({
				transparency = false,
				term_colors = true,
				italics = true,
			})
			vim.cmd([[colorscheme nord]])
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

	{ "nvim-treesitter/playground", cmd = { "TSHighlightCapturesUnderCursor", "TSPlaygroundToggle" } },

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

	{
		"folke/which-key.nvim",
		keys = { "<leader>", '"', "'", "`" },
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("config.which-key")
		end,
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
		"nvim-telescope/telescope.nvim",
		lazy = false,
		priority = 1000,
		dependencies = {
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"kkharji/sqlite.lua",
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
		"anuvyklack/windows.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 5
			vim.o.winminwidth = 5
			vim.o.equalalways = false
			require("windows").setup()
		end,
	},
}
