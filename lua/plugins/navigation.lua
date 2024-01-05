local keys = require("keys")

return {
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		branch = "harpoon2",
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
					["<M-o>"] = function()
						local entry = oil.get_cursor_entry()
						local dir = oil.get_current_dir()
						if not entry or not dir then
							return
						end
						local path = dir .. entry.name
						vim.cmd("!xdg-open '" .. path .. "'")
					end,
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
}
