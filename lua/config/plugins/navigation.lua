local keys = require("keys")

return {
	{
		"ThePrimeagen/harpoon",
		keys = keys.harpoon(),
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
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
						key = "<C-h>",
						command = "split",
					},
				},
			})
		end,
	},
}
