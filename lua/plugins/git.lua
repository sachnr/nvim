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
			"DiffviewFileHistory",
		},
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			file_panel = {
				listing_style = "list",
				tree_options = {
					flatten_dirs = true,
					folder_statuses = "only_folded",
				},
				win_config = { 
					position = "bottom",
                    height = 10,
					win_opts = {},
				},
			},
		},
	},

	{
		"tpope/vim-fugitive",
		enabled = false,
		lazy = false,
	},
}
