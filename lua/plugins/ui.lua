---@diagnostic disable: missing-fields
local keys = require("keys")

return {
	{
		"smjonas/inc-rename.nvim",
		lazy = false,
		config = function()
			require("inc_rename").setup({
				hl_group = "Substitute",
			})
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.quadratic({
						easing = "in",
						duration = 10,
					}),
				},
				symbol = "│",
			})
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
		end,
	},

	{
		"anuvyklack/windows.nvim",
		event = "VeryLazy",
		dependencies = {
			"anuvyklack/middleclass",
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		keys = keys.windows,
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false },
				ignore = {
					filetype = {
						"NvimTree",
						"lspsagaoutline",
						"undotree",
						"outline",
						"dapui_watches",
						"dapui_stacks",
						"dapui_scopes",
						"dapui_breakpoints",
						"dap-repl",
					},
					buftype = { "Outline" },
				},
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
		keys = keys.zenmode(),
		config = true,
	},

	{ "eandrju/cellular-automaton.nvim", event = "VeryLazy" },

	{ "kevinhwang91/nvim-bqf", ft = "qf" },

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"echasnovski/mini.notify",
				version = false,
				opts = {
					lsp_progress = {
						enable = false,
					},
				},
			},
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
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu togetherc
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = true, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- add a border to hover docs and signature help
				},
			})
		end,
	},
}
