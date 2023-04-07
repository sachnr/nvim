local neotree = require("neo-tree")
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neotree.setup({
	source_selector = {
		winbar = true,
		statusline = false,
		tab_labels = { -- table
			filesystem = "  File ", -- string | nil
			git_status = "  Git ", -- string | nil
			buffers = "  Buff ",
		},
	},
	popup_border_style = "single",
	open_files_do_not_replace_types = {
		"terminal",
		"trouble",
		"qf",
		"alpha",
		"lspsagaoutline",
		"dap-repl",
	},
	default_component_configs = {
		git_status = {
			symbols = {
				-- Change type
				added = "",
				modified = "",
				deleted = "",
				renamed = "",
				-- Status type
				untracked = "?",
				ignored = "",
				unstaged = "✘",
				staged = "✓",
				conflict = "",
			},
		},
	},
	window = {
		position = "left",
		width = 30,
	},
	filesystem = {
		follow_current_file = false,
		filtered_items = {
			visible = true,
		},
	},
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				--auto close
				require("neo-tree").close_all()
			end,
		},
	},
})
