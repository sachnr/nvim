local keys = require("keys")

return {
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = "MarkdownPreviewtoggle",
	-- 	build = function()
	-- 		vim.fn["mkdp#util#install"]()
	-- 	end,
	-- 	keys = {
	-- 		{ "<leader>bm", "<cmd> MarkdownPreviewtoggle <cr>", desc = "markdown-preview" },
	-- 	},
	-- },

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
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
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
		init = keys.comment,
		config = true,
	},

	"LudoPinelli/comment-box.nvim",

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
		"famiu/bufdelete.nvim",
		init = keys.bufdelete(),
	},
}
