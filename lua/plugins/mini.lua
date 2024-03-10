return {
	{
		"echasnovski/mini.colors",
		lazy = false,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		event = "VeryLazy",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.none(),
				},
				symbol = "│",
			})
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "Comment" })
		end,
	},
}
