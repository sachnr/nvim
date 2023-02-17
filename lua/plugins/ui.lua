local keys = require("keys")

return {
	-- colorscheme
	{
		"sachnr/base46",
		lazy = false,
		priority = 1000,
		config = function()
			require("base46").setup({
				term_colors = true,
				cokeline = true,
			})
		end,
		dependencies = {
			{
				"noib3/nvim-cokeline",
				keys = keys.cokeline,
			},
			"nvim-tree/nvim-web-devicons",
		},
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
		-- keys = { "<leader>", '"', "'", "`", "@" },
		lazy = false,
		priority = 1000,
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
		event = { "BufWinEnter" },
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
			"nvim-telescope/telescope-project.nvim",
			"gbrlsnchs/telescope-lsp-handlers.nvim",
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("config.telescope")
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		event = { "BufWinEnter" },
		init = keys.nvim_tree(),
		config = function()
			require("config.nvim-tree")
		end,
	},

	{
		"anuvyklack/windows.nvim",
		event = { "BufRead", "BufWinEnter" },
		dependencies = {
			"anuvyklack/middleclass",
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		keys = keys.windows,
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false },
				ignore = {
					filetype = { "NvimTree", "lspsagaoutline", "undotree" },
				},
			})
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		event = { "BufRead", "BufWinEnter" },
		config = function()
			require("config.lspsaga")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
	},

	{
		"noib3/nvim-cokeline",
		keys = keys.cokeline,
		event = { "BufRead", "BufWinEnter" },
		config = function()
			require("config.cokeline")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"utilyre/barbecue.nvim",
		event = { "BufRead", "BufWinEnter" },
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("config.barbecue")
		end,
	},
}
