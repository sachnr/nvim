local keys = require("keys")

return {
	-- colorscheme
	{
		"sachnr/base46",
		lazy = false,
		priority = 1000,
		opts = {
			term_colors = true,
			bufferline = true,
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"akinsho/bufferline.nvim",
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
			require("config.uistuff.lualine")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	{
		lazy = false,
		"goolord/alpha-nvim",
		config = function()
			require("config.uistuff.alpha-nvim")
		end,
	},

	{
		"petertriho/nvim-scrollbar",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.uistuff.scrollbar")
		end,
		dependencies = {
			{
				"kevinhwang91/nvim-hlslens",
				config = function()
					require("config.hls-lens")
				end,
			},
		},
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
			require("config.uistuff.indent-blankline")
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
			-- "nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope-project.nvim",
			-- "gbrlsnchs/telescope-lsp-handlers.nvim",
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
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		init = keys.windows,
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
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.uistuff.lspsaga")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
	},

	-- {
	-- 	"utilyre/barbecue.nvim",
	-- 	event = { "BufEnter" },
	-- 	name = "barbecue",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"SmiteshP/nvim-navic",
	-- 		"nvim-tree/nvim-web-devicons", -- optional dependency
	-- 	},
	-- 	config = function()
	-- 		require("config.barbecue")
	-- 	end,
	-- },

	{
		"anuvyklack/hydra.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.hydra")
		end,
	},
}
