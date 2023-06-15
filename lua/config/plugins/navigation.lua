local keys = require("keys")

return {
	{
		"ThePrimeagen/harpoon",
		keys = keys.harpoon(),
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		lazy = false,
		keys = keys.nvim_tree(),
		config = function()
			require("config.plugins.configs.neotree")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				config = function()
					require("window-picker").setup({
						autoselect_one = true,
						include_current = false,
						filter_rules = {
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
						other_win_hl_color = "#e35e4f",
					})
				end,
			},
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		-- version = "*",
		cmd = "Telescope",
		dependencies = {
			-- "nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			"kkharji/sqlite.lua",
			"nvim-telescope/telescope-project.nvim",
			-- "gbrlsnchs/telescope-lsp-handlers.nvim",
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("config.plugins.configs.telescope")
		end,
	},

	{
		"j-morano/buffer_manager.nvim",
		keys = keys.buffer_manager,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("buffer_manager").setup({
				select_menu_item_commands = {
					v = {
						key = "<C-v>",
						command = "vsplit",
					},
					h = {
						key = "<C-s>",
						command = "split",
					},
				},
			})
		end,
	},

	{
		"stevearc/oil.nvim",
		enabled = true,
		keys = keys.oil(),
		dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			require("oil").setup({
				use_default_keymaps = false,
				default_file_explorer = false,
				skip_confirm_for_simple_edits = true,
				float = {
					-- Padding around the floating window
					padding = 2,
					max_width = 120,
					max_height = 25,
					border = "single",
					win_options = {
						winblend = 0,
					},
				},
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				keymaps = {
					["<C-F5>"] = "actions.refresh",
					["H"] = "actions.parent",
					["<C-s>"] = "actions.select_split",
					["<C-t>"] = "actions.select_tab",
					["<C-v>"] = "actions.select_vsplit",
					["<CR>"] = "actions.select",
					["L"] = "actions.select",
					["<M-j><M-k>"] = "actions.open_cwd",
					["g."] = "actions.toggle_hidden",
					["g?"] = "actions.show_help",
					["q"] = "actions.close",
				},
				view_options = {
					show_hidden = true,
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					is_always_hidden = function(name, bufnr)
						return false
					end,
				},
			})
		end,
	},

	{
		"folke/edgy.nvim",
		lazy = false,
		opts = {
			left = {
				-- {
				-- 	ft = "oil",
				-- 	title = "File System",
				-- 	size = { width = 30 },
				-- },
				{
					ft = "neotree",
					title = "File System",
					size = { width = 30 },
				},
			},
			bottom = {
				{ ft = "qf", title = "QuickFix" },
				{
					ft = "help",
					size = { height = 20 },
					-- only show help buffers
					filter = function(buf)
						return vim.bo[buf].buftype == "help"
					end,
				},
			},
			right = {
				{
					ft = "symbols-outline",
					size = { width = 30 },
				},
			},
		},
	},
}
