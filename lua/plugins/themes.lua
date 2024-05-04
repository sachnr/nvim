return {
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("kanagawa").setup({
	-- 			compile = false, -- enable compiling the colorscheme
	-- 			undercurl = true, -- enable undercurls
	-- 			commentStyle = { italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = { italic = true },
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			transparent = false, -- do not set background color
	-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 			colors = { -- add/modify theme and palette colors
	-- 				palette = {},
	-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 			},
	-- 			overrides = function(colors) -- add/modify highlights
	-- 				return {}
	-- 			end,
	-- 			theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- 			background = { -- map the value of 'background' option to a theme
	-- 				dark = "wave", -- try "dragon" !
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd("colorscheme kanagawa-dragon")
	-- 	end,
	-- },

	-- {
	-- 	"askfiy/visual_studio_code",
	-- 	event = "VeryLazy",
	-- 	enabled = true,
	-- 	priority = 100,
	-- },

	{
		"ellisonleao/gruvbox.nvim",
		event = "VeryLazy",
		enabled = true,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				undercurl = true,
				underline = false,
				bold = false,
				---@diagnostic disable-next-line: missing-fields
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
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},

	-- {
	-- 	"neanias/everforest-nvim",
	-- 	event = "VeryLazy",
	-- 	enabled = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("everforest").setup({
	-- 			-- Your config here
	-- 			background = "hard",
	-- 		})
	-- 		vim.cmd("colorscheme everforest")
	-- 	end,
	-- },

	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	enabled = true,
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nightfox").setup({
	-- 			options = {
	-- 				styles = {
	-- 					comments = "italic",
	-- 					conditionals = "NONE",
	-- 					constants = "NONE",
	-- 					functions = "NONE",
	-- 					keywords = "NONE",
	-- 					numbers = "NONE",
	-- 					operators = "NONE",
	-- 					strings = "NONE",
	-- 					types = "NONE",
	-- 					variables = "NONE",
	-- 				},
	-- 			},
	-- 		})
	-- 		vim.cmd("colorscheme carbonfox")
	-- 	end,
	-- },

	-- {
	-- 	"sainnhe/sonokai",
	-- 	enabled = true,
	-- 	event = "VeryLazy",
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.g.sonokai_style = "espresso"
	-- 		-- vim.cmd("colorscheme sonokai")
	-- 	end,
	-- },

	-- { "catppuccin/nvim", lazy = false, name = "catppuccin", priority = 1000, config = true },
	-- { "EdenEast/nightfox.nvim", lazy = false, priority = 1000, config = true },

	-- {
	-- 	"navarasu/onedark.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("onedark").setup({
	-- 			style = "darker",
	-- 		})
	-- 		require("onedark").load()
	-- 	end,
	-- },
}
