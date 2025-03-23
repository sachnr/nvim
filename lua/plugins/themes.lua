return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	init = function()
	-- 		vim.cmd("colorscheme tokyonight")
	-- 	end,
	-- },

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
	-- 	"Shatur/neovim-ayu",
	-- 	lazy = false,
	-- 	enabled = true,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("ayu").setup({
	-- 			mirage = false,
	-- 			terminal = true,
	-- 		})
	-- 		vim.cmd("colorscheme ayu")
	-- 		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#68d4ff", underline = false })
	-- 	end,
	-- },

	-- {
	-- 	"askfiy/visual_studio_code",
	-- 	event = "VeryLazy",
	-- 	enabled = true,
	-- 	priority = 100,
	-- },

	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	event = "VeryLazy",
	-- 	enabled = true,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("gruvbox").setup({
	-- 			undercurl = true,
	-- 			underline = false,
	-- 			bold = false,
	-- 			---@diagnostic disable-next-line: missing-fields
	-- 			italic = {
	-- 				strings = false,
	-- 				comments = true,
	-- 				operators = false,
	-- 				folds = true,
	-- 			},
	-- 			strikethrough = true,
	-- 			invert_selection = false,
	-- 			invert_signs = false,
	-- 			invert_tabline = false,
	-- 			invert_intend_guides = false,
	-- 			inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 			contrast = "soft", -- can be "hard", "soft" or empty string
	-- 			palette_overrides = {},
	-- 			overrides = {},
	-- 			dim_inactive = false,
	-- 			transparent_mode = false,
	-- 		})
	-- 	end,
	-- 	init = function()
	-- 		vim.cmd("colorscheme gruvbox")
	-- 	end,
	-- },

	-- {
	-- 	"neanias/everforest-nvim",
	-- 	event = "VeryLazy",
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
	--                    transparent = false,
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
	-- 		vim.cmd("colorscheme dawnfox")
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

	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = true,
		opts = {
			color_overrides = {
				mocha = {
					rosewater = "#F5B8AB",
					flamingo = "#F29D9D",
					pink = "#AD6FF7",
					mauve = "#FF8F40",
					red = "#E66767",
					maroon = "#EB788B",
					peach = "#FAB770",
					yellow = "#FACA64",
					green = "#70CF67",
					teal = "#4CD4BD",
					sky = "#61BDFF",
					sapphire = "#4BA8FA",
					blue = "#00BFFF",
					lavender = "#00BBCC",
					text = "#C1C9E6",
					subtext1 = "#A3AAC2",
					subtext0 = "#8E94AB",
					overlay2 = "#7D8296",
					overlay1 = "#676B80",
					overlay0 = "#464957",
					surface2 = "#3A3D4A",
					surface1 = "#2F313D",
					surface0 = "#1D1E29",
					base = "#0b0b12",
					mantle = "#11111a",
					crust = "#191926",
				},
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad",
				},
			},
		},
		init = function()
			vim.cmd("colorscheme catppuccin-mocha")
		end,
	},

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

	-- {
	-- 	"ribru17/bamboo.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("bamboo").setup({
	-- 			style = "multiplex",
	-- 			transparent = false,
	-- 			toggle_style_key = "<leader-F1>", -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
	-- 			toggle_style_list = { "multiplex", "light" }, -- List of styles to toggle between
	-- 		})
	-- 		require("bamboo").load()
	-- 	end,
	-- },

	-- {
	-- 	"ramojus/mellifluous.nvim",
	-- 	lazy = false,
	-- 	config = function()
	-- 		require("mellifluous").setup({
	-- 			require("mellifluous").setup({
	-- 				colorset = "kanagawa_dragon",
	-- 			}),
	-- 		}) -- optional, see configuration section.
	-- 		vim.cmd("colorscheme mellifluous")
	-- 	end,
	-- },
}
