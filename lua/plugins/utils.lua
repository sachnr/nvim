local keys = require("keys")

return {
	-- markdown preview
	--
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	build = "yarn build",
	-- 	keys = {
	-- 		{ "<leader>pm", "<cmd> MarkdownPreviewtoggle <cr>", desc = "markdown-preview" },
	-- 	},
	-- },
	--
	{
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		keys = keys.peek,
		opts = { theme = "light" },
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
		"karb94/neoscroll.nvim",
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
