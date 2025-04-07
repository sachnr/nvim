local keys = require("keys")

return {
	"nvim-lua/plenary.nvim",

	"nvim-tree/nvim-web-devicons",

	{
		"gbprod/yanky.nvim",
		keys = {
			{ "y", mode = { "n", "x" }, "<Plug>(YankyYank)", desc = "Yanky Yank" },
			{ "p", mode = { "n", "x" }, "<Plug>(YankyPutAfter)", desc = "Yanky Put After" },
			{ "P", mode = { "n", "x" }, "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
			{ "<c-n>", mode = "n", "<Plug>(YankyCycleForward)", desc = "Yanky Cycle Forward" },
			{ "<c-p>", mode = "n", "<Plug>(YankyCycleBackward)", desc = "Yanky Cycle Back" },
			{ "<leader>p", mode = { "n", "x" }, "<cmd> Telescope yank_history <CR>", desc = "Paste from Yanky" },
		},
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
		config = true,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	{
		"echasnovski/mini.colors",
		enabled = true,
	},
}
