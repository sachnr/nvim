local keys = require("keys")

return {
	{ "j-hui/fidget.nvim", event = { "BufRead", "BufWinEnter" }, config = true },

	{ "rcarriga/nvim-notify", lazy = false, config = true },

	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		config = function()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = {
							default = false,
							group = "lualine_a_normal",
						},
						InclineNormalNC = {
							default = false,
							group = "lualine_c_normal",
						},
					},
				},
				render = function(props)
					local get_hex = function(hlgroup_name, attr)
						local hlgroup_ID = vim.fn.synIDtrans(vim.fn.hlID(hlgroup_name))
						local hex = vim.fn.synIDattr(hlgroup_ID, attr)
						return hex ~= "" and hex or "NONE"
					end
					local normal = get_hex("Normal", "bg")
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
		enabled = false,
		lazy = false,
		config = function()
			require("indent_blankline").setup({
				char = "▎",
				use_treesitter = true,
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"dashboard",
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

	{
		"anuvyklack/windows.nvim",
		lazy = false,
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
					filetype = { "NvimTree", "lspsagaoutline", "undotree", "outline" },
					buftype = { "Outline" },
				},
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
    keys = keys.zenmode(),
    config = true
	},
}
