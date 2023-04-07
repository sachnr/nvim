local keys = require("keys")

return {
	"j-hui/fidget.nvim",
	"rcarriga/nvim-notify",

	{
		"b0o/incline.nvim",
        lazy = false,
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = {
							default = false,
							group = "TablineSel",
						},
						InclineNormalNC = {
							default = false,
							group = "Tabline",
						},
					},
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
					local modified = vim.api.nvim_buf_get_option(props.buf, "modified") and "bold,italic" or "bold"
					local buffer = {
						{ ft_icon, guifg = ft_color, guibg = "NONE" },
						{ " " },
						{ filename, gui = modified },
					}
					return buffer
				end,
			})
		end,
	},

	{
		"petertriho/nvim-scrollbar",
        lazy = false,
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
        lazy = false,
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
