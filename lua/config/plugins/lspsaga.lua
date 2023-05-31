return {
	{
		"glepnir/lspsaga.nvim",
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
