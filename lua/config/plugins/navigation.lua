local keys = require("keys")

return {
	{
		"ThePrimeagen/harpoon",
		keys = keys.harpoon(),
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		keys = keys.nvim_tree(),
		config = function()
			require("config.plugins.configs.neotree")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},

	{
		"nvim-telescope/telescope.nvim",
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
