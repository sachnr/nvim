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

	{
		"akinsho/toggleterm.nvim",
		config = true,
	},

	{
		"NvChad/nvim-colorizer.lua",
		enabled = true,
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			user_default_options = {
				names = false,
				mode = "virtualtext",
				tailwind = "lsp",
			},
		},
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
				"<cmd> Trouble diagnostics <CR>",
				desc = "trouble",
			},
		},
		cmd = "Trouble diagnostics",
		config = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
