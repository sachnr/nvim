return {
	{
		dir = "~/Downloads/base46/",
		enabled = false,
		lazy = false,
		priority = 1000,
		opts = {
			bold = true,
			simple_lualine = true,
			underline = true,
		},
	},

	{ "sainnhe/gruvbox-material", enabled = false, lazy = false, priority = 1000 },

	{
		"rebelot/kanagawa.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = {
						wave = {},
						lotus = {},
						dragon = {},
						all = {},
					},
				},
				overrides = function(colors) -- add/modify highlights
					return {
						WinSeparator = { fg = "#282727", bg = "None" },
						StatusLine = { fg = "None", bg = "None" },
						FloatBorder = { fg = "#282727", bg = "#181616" },
						FloatTitle = { fg = "#181616", bg = "#c4746e", bold = true },
						NormalFloat = { bg = "#181616" },
						TelescopeBorder = { bg = "#282727", fg = "#282727" },
						TelescopePromptBorder = { bg = "#282727", fg = "#7A8382" },
						TelescopePromptNormal = { fg = "#7A8382", bg = "#282727" },
						TelescopeNormal = { bg = "#282727" },
						TelescopePreviewTitle = { fg = "#181616", bg = "#8ba4b0", bold = true },
						TelescopePromptTitle = { fg = "#181616", bg = "#c4746e", bold = true },
						TelescopeResultsTitle = { fg = "#181616", bg = "#8a9a7b", bold = true },
					}
				end,
				theme = "dragon", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
		init = function()
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				bold_vert_split = true,
				disable_italics = true,
				highlight_groups = {
					-- indent blankline
					IndentBlanklineChar = { fg = "surface" },
					IndentBlanklineSpaceChar = { fg = "surface" },
					IndentBlanklineSpaceCharBlankline = { fg = "surface" },
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
