---@diagnostic disable: missing-fields
local keys = require("keys")

return {
	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none()
				},
				symbol = "│",
			})
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
		end,
	},

	{
		"nvim-focus/focus.nvim",
		version = false,
		event = "VeryLazy",
		config = function()
			require("focus").setup({ commands = false, ui = { signcolumn = false } })

			local ignore_filetypes = {
				"undotree",
				"dapui_watches",
				"dapui_stacks",
				"dapui_scopes",
				"dapui_breakpoints",
				"dap-repl",
				"DiffviewFiles",
				"qf",
			}
			local ignore_buftypes = {
				"quickfix",
				"nofile",
				"prompt",
				"popup",
			}
			local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
			vim.api.nvim_create_autocmd("WinEnter", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
						vim.w.focus_disable = true
					else
						vim.w.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for BufType",
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
						vim.b.focus_disable = true
					else
						vim.b.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for FileType",
			})
		end,
	},

	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {
			select = {
				backend = { "nui", "builtin" },
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		keys = keys.zenmode(),
		config = true,
	},

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					minimum_width = 50,
					render = "wrapped-compact",
					stages = "fade",
					top_down = true,
				},
			},
			-- {
			-- 	-- "echasnovski/mini.notify",
			-- 	version = false,
			-- 	opts = {
			-- 		lsp_progress = {
			-- 			enable = false,
			-- 		},
			-- 	},
			-- },
		},
		config = function()
			require("noice").setup({
				lsp = {
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
					signature = {
						enabled = true,
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = false, -- position the cmdline and popupmenu togetherc
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
