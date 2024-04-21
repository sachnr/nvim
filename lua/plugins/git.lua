return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
				numhl = false,
			})
		end,
	},

	{
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
			"DiffviewRefresh",
			"DiffviewFileHistory",
		},
		dependencies = "nvim-lua/plenary.nvim",
	},

	{
		"tpope/vim-fugitive",
		lazy = false,
	},
}
