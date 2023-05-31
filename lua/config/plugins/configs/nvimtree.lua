local nvimtree = require("nvim-tree")

local options = {
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	sync_root_with_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	view = {
		relativenumber = false,
		hide_root_folder = true,
		centralize_selection = false,
		preserve_window_proportions = true,
	},
	filesystem_watchers = {
		enable = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			error = " ",
			warning = " ",
			info = " ",
			hint = " ",
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
			resize_window = false,
			window_picker = {
				chars = "1234567890",
			},
		},
	},
	renderer = {
		highlight_git = true,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			-- icons = {
			-- 	corner = "╰",
			-- 	edge = "│",
			-- 	item = "│",
			-- 	bottom = "─",
			-- 	none = " ",
			-- },
		},
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "✘",
					ignored = "◌",
				},
			},
		},
	},
}

nvimtree.setup(options)
