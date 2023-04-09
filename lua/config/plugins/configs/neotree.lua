local neotree = require("neo-tree")
local fc = require("neo-tree.sources.filesystem.components")
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neotree.setup({
	source_selector = {
		winbar = true,
		statusline = true,
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
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
		},
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
		follow_current_file = true,
		use_libuv_file_watcher = true,
		components = {
			name = function(config, node, state)
				local result = fc.name(config, node, state)
				if node:get_depth() == 1 and node.type ~= "message" then
					result.text = vim.fn.fnamemodify(node.path, ":t")
				end
				return result
			end,
		},
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
