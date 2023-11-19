local keys = require("keys")

return {
	{
		"ThePrimeagen/harpoon",
		keys = keys.harpoon(),
		dependencies = { "nvim-lua/plenary.nvim" },
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
		"echasnovski/mini.files",
		keys = keys.files(),
		enabled = false,
		version = false,
		config = function()
			require("mini.files").setup({
				mappings = {
					close = "q",
					go_in = "L",
					go_in_plus = "<CR>",
					go_out = "H",
					go_out_plus = "",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "<leader>s",
					trim_left = "<",
					trim_right = ">",
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
			local oil = require("oil")
			oil.setup({
				use_default_keymaps = false,
				default_file_explorer = false,
				skip_confirm_for_simple_edits = true,
				float = {
					-- Padding around the floating window
					padding = 2,
					max_width = 120,
					max_height = 25,
					border = "none",
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
					["<C-s>"] = function()
						oil.select({ horizontal = true, close = true })
					end,
					["<C-t>"] = function()
						oil.select({ tab = true, close = true })
					end,
					["<C-v>"] = function()
						oil.select({ vertical = true, close = true })
					end,
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
                        return name == ".."
					end,
				},
			})
		end,
	},

	{
		"folke/edgy.nvim",
		enabled = false,
		lazy = false,
		opts = {
			animate = {
				enabled = false,
			},
			wo = {
				-- Setting to `true`, will add an edgy winbar.
				-- Setting to `false`, won't set any winbar.
				-- Setting to a string, will set the winbar to that string.
				winbar = false,
				winfixwidth = true,
				winfixheight = false,
				winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
				spell = false,
				signcolumn = "no",
			},
			left = {
				{
					ft = "neotree",
					title = "File System",
					size = { width = 30 },
				},
			},
			bottom = {
				"Trouble",
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
