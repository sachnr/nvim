return {

	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},

	{
		"rebelot/kanagawa.nvim",
		enabled = false,
		priority = 1000,
		init = function()
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},

	{
		"savq/melange-nvim",
		enabled = false,
		lazy = false,
		config = function()
			vim.cmd.colorscheme("melange")
		end,
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
				underline = false,
				bold = false,
				italic = {
					strings = false,
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
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					styles = {
						comments = "italic",
						conditionals = "NONE",
						constants = "NONE",
						functions = "NONE",
						keywords = "NONE",
						numbers = "NONE",
						operators = "NONE",
						strings = "NONE",
						types = "NONE",
						variables = "NONE",
					},
				},
			})
			vim.cmd("colorscheme terafox")
		end,
	},

	{
		"Yazeed1s/oh-lucy.nvim",
		enabled = false,
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
