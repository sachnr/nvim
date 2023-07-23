return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			-- "kkharji/sqlite.lua",
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local telescope = require("telescope")
			local extensions_list = { "yank_history" }

			for _, ext in ipairs(extensions_list) do
				telescope.load_extension(ext)
			end

			local options = {
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					multi_icon = " + ",
					borders = false,
					borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						cursor = {
							height = 0.9,
							preview_cutoff = 40,
							width = 0.8,
						},
						horizontal = {
							height = 0.9,
							preview_cutoff = 120,
							preview_width = function(_, cols, _)
								if cols > 200 then
									return math.floor(cols * 0.4)
								else
									return math.floor(cols * 0.6)
								end
							end,
							prompt_position = "top",
							width = 0.8,
						},
					},
					results_title = "results",
					file_ignore_patterns = {
						"node_modules",
						".git/",
					},
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					path_display = { "truncate" },
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					-- history = {
					-- 	path = vim.fn.stdpath("data") .. "/databases/telescope_history.sqlite3",
					-- 	limit = 100,
					-- },
					mappings = {
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
				},

				extensions = {
					fzy_native = {
						override_generic_sorter = true,
						override_file_sorter = true,
					},

					fzf_writer = {
						use_highlighter = false,
						minimum_grep_characters = 6,
					},

					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			}

			-- Temporay workaround for bug: https://github.com/nvim-telescope/telescope.nvim/issues/2027#issuecomment-1510001730
			vim.api.nvim_create_autocmd("WinLeave", {
				callback = function()
					if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
						vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
					end
				end,
			})

			telescope.setup(options)
		end,
	},
}
