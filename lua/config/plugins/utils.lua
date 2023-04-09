local keys = require("keys")

return {
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		keys = keys.peek(),
		config = function()
			require("peek").setup({
				syntax = true, -- enable syntax highlighting, affects performance
				theme = "dark", -- 'dark' or 'light'
				app = "chromium", -- 'webview', 'browser', string or a table of strings
			})
		end,
	},

	{
		"gbprod/yanky.nvim",
		keys = keys.yanky(),
		config = function()
			require("yanky").setup({
				system_clipboard = {
					sync_with_ring = true,
				},
				highlight = {
					timer = 150,
				},
			})
		end,
		dependencies = {
			{ "kkharji/sqlite.lua" },
		},
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
		"akinsho/toggleterm.nvim",
		keys = keys.toggleterm(),
		config = function()
			require("toggleterm").setup({
				shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
				shading_factor = -15,
			})
		end,
	},

	{
		"chentoast/marks.nvim",
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
}
