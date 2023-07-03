return {
	{
		"CosmicNvim/cosmic-ui",
		opts = {
			border_style = "single",
			rename = {
				border = {
					highlight = "FloatBorder",
					style = "single",
					title = " Rename ",
					title_align = "center",
					title_hl = "FloatTitle",
				},
				prompt = "> ",
				prompt_hl = "Comment",
			},

			code_actions = {
				min_width = nil,
				border = {
					bottom_hl = "FloatBorder",
					highlight = "FloatBorder",
					style = "single",
					title = "Code Actions",
					title_align = "center",
					title_hl = "FloatTitle",
				},
			},
		},
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	},
	{
		"glepnir/lspsaga.nvim",
		enabled = false,
		lazy = false,
		config = function()
			require("lspsaga").setup({
				preview = {
					lines_above = 0,
					lines_below = 20,
				},
				scroll_preview = {
					scroll_down = "<C-d>",
					scroll_up = "<C-u>",
				},
				finder = {
					max_height = 0.5,
					min_width = 30,
					keys = {
						jump_to = "d",
						expand_or_jump = "l",
						vsplit = "<C-v>",
						split = "<C-s>",
					},
				},
				code_action = {
					show_server_name = false,
					extend_gitsigns = false,
				},
				lightbulb = {
					enable = false,
				},
				diagnostic = {
					on_insert_follow = true,
					text_hl_follow = false,
					border_follow = true,
				},
				rename = {
					quit = "<C-c>",
					exec = "<CR>",
					mark = "x",
					confirm = "<CR>",
					in_select = true,
				},
				outline = {
					keys = {
						expand_or_jump = "<CR>",
					},
				},
				symbol_in_winbar = {
					enable = false,
					separator = "  ",
				},
				ui = {
					title = true,
					-- Border type can be single, double, rounded, solid, shadow.
					border = "single",
					expand = "",
					collapse = "",
					preview = "󰍉 ",
					code_action = "",
				},
			})
		end,
		dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
	},
}
