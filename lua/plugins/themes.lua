return {
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	lazy = false,
	-- 	enabled = true,
	-- 	priority = 1000,
	-- 	init = function()
	-- 		require("kanagawa").setup({
	-- 			compile = true, -- enable compiling the colorscheme
	-- 			transparent = true,
	-- 			theme = "dragon",
	-- 			background = {
	-- 				dark = "dragon",
	-- 				light = "lotus",
	-- 			},
	-- 		})
	-- 		vim.cmd("colorscheme kanagawa-dragon")
	-- 	end,
	-- },
	--
	-- {
	-- 	"askfiy/visual_studio_code",
	-- 	event = "VeryLazy",
	-- 	enabled = true,
	-- 	priority = 100,
	-- },
	--
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
	-- 			contrast = "", -- can be "hard", "soft" or empty string
	-- 			palette_overrides = {},
	-- 			overrides = {},
	-- 			dim_inactive = false,
	-- 			transparent_mode = false,
	-- 		})
	-- 	end,
	-- },
	--
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
	--
	-- {
	-- 	"EdenEast/nightfox.nvim",
	-- 	enabled = false,
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
	-- 		-- vim.cmd("colorscheme terafox")
	-- 	end,
	-- },
	--
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
}
