local keys = require("keys")

return {
	"nvim-lua/plenary.nvim",

	"nvim-tree/nvim-web-devicons",

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

	-- {
	-- 	"numToStr/Comment.nvim",
	-- 	event = { "BufRead", "BufWinEnter", "BufNewFile" },
	-- 	opts = {
	-- 		-- add any options here
	-- 	},
	-- },

	{
		"akinsho/toggleterm.nvim",
		config = true,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		enabled = true,
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({
				render = "virtual",
				enable_named_colors = false,
				enable_tailwind = true,
			})
		end,
	},

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
			require("neogen").setup({ snippet_engine = "luasnip" })
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
