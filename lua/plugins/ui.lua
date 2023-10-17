local keys = require("keys")

return {
	{ "j-hui/fidget.nvim", tag = "legacy", event = "BufReadPre", config = true },

	{
		"CosmicNvim/cosmic-ui",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("cosmic-ui").setup({
				opts = {
					border_style = "single",
					rename = {
						border = {
							highlight = "FloatBorder",
							style = "single",
							title = "Rename",
							title_align = "center",
							title_hl = "FloatTitle",
						},
						prompt = "> ",
						prompt_hl = "Comment",
					},
				},
			})
		end,
	},

	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		config = function()
			require("incline").setup({
				window = {
					placement = {
						horizontal = "right",
						vertical = "bottom",
					},
				},
				highlight = {
					groups = {
						InclineNormal = {
							default = false,
							group = "lualine_b_normal",
						},
						InclineNormalNC = {
							default = false,
							group = "lualine_c_normal",
						},
					},
				},
				render = function(props)
					local normal = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("Normal")), "bg", "gui")
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
		enabled = false,
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
					"NeoTree",
					"alpha",
					"dashboard",
					"packer",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
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
		"shellRaining/hlchunk.nvim",
		event = "VeryLazy",
		config = function()
			require("hlchunk").setup({
				chunk = {
					style = {
						{ fg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("FloatBorder")), "fg", "gui") },
					},
				},
				indent = {
					enable = false,
				},
				line_num = {
					enable = false,
				},
				blank = {
					enable = false,
				},
			})
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
					filetype = { "NvimTree", "lspsagaoutline", "undotree", "outline" },
					buftype = { "Outline" },
				},
			})
		end,
	},

	{
		"folke/zen-mode.nvim",
		keys = keys.zenmode(),
		config = function()
			require("zen-mode").setup({
				window = {
					backdrop = 0.8,
				},
			})
		end,
	},
}
