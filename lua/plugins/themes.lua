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

	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	{ "sainnhe/gruvbox-material", enabled = false, lazy = false, priority = 1000 },

	{
		"rebelot/kanagawa.nvim",
		enabled = false,
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
			vim.cmd("colorscheme rose-pine-main")
		end,
	},

	{
		"savq/melange-nvim",
		enabled = false,
		lazy = false,
	},

	{
		"ribru17/bamboo.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("bamboo").setup({
				-- optional configuration here
			})
			require("bamboo").load()
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		enabled = false,
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.cmd("colorscheme gruvbox")
		end,
	},

	{
		"sainnhe/everforest",
		enabled = false,
		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_better_performance = 1
		end,
	},

	{
		"neanias/everforest-nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				-- Your config here
				background = "hard",
			})
			vim.cmd("colorscheme everforest")
		end,
	},

	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = false, -- Disable setting background
					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
					dim_inactive = false, -- Non focused panes set to alternative background
					styles = { -- Style to be applied to different syntax groups
						comments = "italic", -- Value is any valid attr-list value `:help attr-list`
						conditionals = "NONE",
						constants = "NONE",
						functions = "bold",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
					inverse = { -- Inverse highlight for different types
						match_paren = false,
						visual = false,
						search = false,
					},
					modules = { -- List of various plugins and additional options
						-- ...
					},
				},
				palettes = {},
				specs = {},
				groups = {},
			})

			vim.cmd("colorscheme terafox")
		end,
	},

	{
		"Yazeed1s/oh-lucy.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme oh-lucy]])
			vim.api.nvim_set_hl(0, "PmenuSel", { fg = "#E0828D" })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#E0828D" })
			vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#322F32", fg = "#DED7D0" })
			vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#29292E", fg = "#DED7D0" })
			vim.api.nvim_set_hl(0, "Conceal", { fg = "#1E1D23" })
		end,
	},
}
