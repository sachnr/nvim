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
		"NvChad/nvim-colorizer.lua",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("colorizer").setup({
				filetypes = {
					"*",
				},
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue or blue
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					AARRGGBB = true, -- 0xAARRGGBB hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = false, -- CSS hsl() and hsla() functions
					css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					-- Available modes for `mode`: foreground, background,  virtualtext
					mode = "background", -- Set the display mode.
					virtualtext = "■",
				},
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
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = true,
	},

	"famiu/bufdelete.nvim",
}
