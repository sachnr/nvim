return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<Leader>tf", mode = "n", "<cmd> Telescope find_files <CR>", desc = "find files" },
			{ "<Leader>tg", mode = "n", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
			{ "<Leader>to", mode = "n", "<cmd> Telescope oldfiles <CR>", desc = "live grep" },
			{ "<Leader>tu", mode = "n", "<cmd> silent! %foldopen! | UndotreeToggle <CR>", desc = "UndotreeToggle" },
			{ "<Leader>t/", mode = "n", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "search in file" },
		},
		dependencies = {
			-- "kkharji/sqlite.lua",
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")

			local options = {
				defaults = {
					sorting_strategy = "ascending",
					file_ignore_patterns = {
						"libs",
						"node_modules",
						".git/",
					},
					mappings = {
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
			}

			telescope.setup(options)
		end,
	},
}
