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
		"chentoast/marks.nvim",
		enabled = false,
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},

	{
		"brenoprata10/nvim-highlight-colors",
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
		keys = keys.neogen(),
		cmd = "Neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
	},

	{
		"echasnovski/mini.pairs",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("mini.pairs").setup()
		end,
	},

	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
	},

	{
		"folke/trouble.nvim",
		keys = keys.trouble(),
		cmd = "Trouble",
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
		"yorickpeterse/nvim-pqf",
		event = "VeryLazy",
		config = function()
			local icons = require("icons")
			require("pqf").setup({
				signs = {
					error = icons.diagnostics.error,
					warning = icons.diagnostics.warn,
					info = icons.diagnostics.info,
					hint = icons.diagnostics.hint,
				},

				-- By default, only the first line of a multi line message will be shown.
				-- When this is true, multiple lines will be shown for an entry, separated by a space
				show_multiple_lines = false,

				-- How long filenames in the quickfix are allowed to be. 0 means no limit.
				-- Filenames above this limit will be truncated from the beginning with [...]
				max_filename_length = 0,
			})
		end,
	},

	"famiu/bufdelete.nvim",
}
