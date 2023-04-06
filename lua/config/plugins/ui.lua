local keys = require("keys")

return {
	{
		dir = "~/Downloads/base46/",
		lazy = false,
		priority = 1000,
		opts = {
			italic = true,
			simple_lualine = true,
		},
	},

	"j-hui/fidget.nvim",
	"rcarriga/nvim-notify",

	{
		"petertriho/nvim-scrollbar",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("scrollbar").setup({
				set_highlights = false,
				handle = {
					hide_if_all_visible = true, -- Hides handle if all lines are visible
				},
				excluded_filetypes = {
					"prompt",
					"TelescopePrompt",
					"noice",
					"NvimTree",
				},
				handlers = {
					cursor = false,
					diagnostic = true,
					gitsigns = false, -- Requires gitsigns
					handle = true,
					search = true, -- Requires hlslens
				},
				marks = {
					Search = {
						text = { "" },
					},
					Error = {
						text = { "" },
					},
				},
			})
		end,
		dependencies = {
			{
				"kevinhwang91/nvim-hlslens",
				config = function()
					require("scrollbar.handlers.search").setup({
						calm_down = true,
					})
					keys.hlslens()
				end,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("indent_blankline").setup({
				char = "▎",
				use_treesitter = true,
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"packer",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
					"",
				},
				buftype_exclude = { "terminal" },
				show_first_indent_level = false,
				show_current_context = true,
			})
		end,
	},
}
