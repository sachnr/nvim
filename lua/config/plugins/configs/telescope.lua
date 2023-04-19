local present, telescope = pcall(require, "telescope")

if not present then
	return
end

local extensions_list = { "project", "yank_history" }
pcall(function()
	for _, ext in ipairs(extensions_list) do
		telescope.load_extension(ext)
	end
end)

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
		history = {
			path = vim.fn.stdpath("data") .. "/databases/telescope_history.sqlite3",
			limit = 100,
		},
		mappings = {
			n = {
				["d"] = require("telescope.actions").delete_buffer,
			},
			i = {
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-d>"] = require("telescope.actions").delete_buffer,
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

telescope.setup(options)
