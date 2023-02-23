local keys = require("keys")

return {
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		keys = keys.peek,
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
		keys = keys.yanky,
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
		cmd = "Comment",
		keys = keys.comment,
		config = true,
	},

	"LudoPinelli/comment-box.nvim",
	"famiu/bufdelete.nvim",

	{
		"akinsho/toggleterm.nvim",
		config = true,
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
			require("config.nvim-colorizer")
		end,
	},

	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
