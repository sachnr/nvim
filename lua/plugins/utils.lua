local keys = require("keys")

return {
	"nvim-lua/plenary.nvim",

	"nvim-tree/nvim-web-devicons",

	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
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
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("Comment").setup()
			-- require("Comment.ft").set("lua", { "--%s", "--[[%s]]" })
		end,
	},

	{
		"LudoPinelli/comment-box.nvim",
		keys = keys.comment_box(),
	},

	{
		"akinsho/toggleterm.nvim",
		keys = keys.toggleterm(),
		event = "ColorScheme",
		config = true,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		enabled = false,
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background",
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
			require("neogen").setup({ snippet_engine = "neovim" })
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

	{
		"folke/which-key.nvim",
		-- keys = { "<leader>", '"', "'", "`", "@" },
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			local wk = require("which-key")

			local options = {
				window = {
					border = "single", -- none, single, double, shadow
				},
			}

			wk.setup(options)
		end,
	},
}
