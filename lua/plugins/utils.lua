local keys = require("keys")

return {
	"nvim-lua/plenary.nvim",

	"nvim-tree/nvim-web-devicons",

	{
		"echasnovski/mini.colors",
		lazy = false,
	},

	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		enable = false,
		keys = keys.peek(),
		config = function()
			require("peek").setup({
				syntax = true, -- enable syntax highlighting, affects performance
				theme = "dark", -- 'dark' or 'light'
				app = "brave", -- 'webview', 'browser', string or a table of strings
			})
		end,
	},

	{
		"gbprod/yanky.nvim",
		keys = keys.yanky(),
		config = function()
			require("yanky").setup({
				storage = "shada",
				system_clipboard = {
					sync_with_ring = true,
				},
			})
		end,
	},

	{
		"echasnovski/mini.comment",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("mini.comment").setup()
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		config = true,
	},

	-- {
	-- 	"brenoprata10/nvim-highlight-colors",
	-- 	enabled = true,
	-- 	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	-- 	config = function()
	-- 		require("nvim-highlight-colors").setup({
	-- 			render = "first_column",
	-- 			enable_named_colors = false,
	-- 			enable_tailwind = true,
	-- 		})
	-- 	end,
	-- },

	{
		"danymat/neogen",
		keys = {
			{
				"<Leader>N",
				mode = "n",
				"<cmd> Neogen <CR>",
				desc = "generate docs",
			},
		},
		cmd = "Neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({ snippet_engine = "nvim" })
		end,
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	{
		"folke/trouble.nvim",
		keys = {
			{
				"<Leader>E",
				mode = "n",
				"<cmd> TroubleToggle <CR>",
				desc = "trouble",
			},
		},
		cmd = "TroubleToggle",
		config = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"m4xshen/hardtime.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
	},
}
