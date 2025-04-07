return {
	{
		"lewis6991/gitsigns.nvim",
		keys = {
			{ "<leader>gb", "<cmd> lua require('gitsigns').blame_line <cr>", { desc = "git blame" } },
		},
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
		"tpope/vim-fugitive",
		config = function()
			vim.gitgutter_diff_base = "HEAD"
			vim.keymap.set("n", "<leader>G", vim.cmd.Git)
			vim.keymap.set("n", "g2", "<cmd>diffget //2<CR>")
			vim.keymap.set("n", "g3", "<cmd>diffget //3<CR>")
			vim.keymap.set("n", "<leader>gd", "<cmd> Gdiff! <CR>")
			vim.keymap.set("n", "<leader>gm", "<cmd> Git mergetool <CR>")
		end,
	},
}
