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
		"akinsho/git-conflict.nvim",
		event = "VeryLazy",
		opts = {
			default_mappings = {
				none = "<leader>g0",
				ours = "<leader>g1",
				theirs = "<leader>g2",
				both = "<leader>g3",
				prev = "[g",
				next = "]g",
			},
			disable_diagnostics = true,
		},
	},
}
