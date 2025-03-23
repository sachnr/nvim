local keys = require("keys")

return {
	{
		"stevearc/oil.nvim",
		keys = keys.oil(),
		dependencies = { "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			local oil = require("oil")
			oil.setup({
				use_default_keymaps = false,
				default_file_explorer = false,
				skip_confirm_for_simple_edits = true,
				columns = { "icon" },
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
					show_hidden = false,
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
