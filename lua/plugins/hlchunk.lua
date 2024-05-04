return {
	{
		"shellRaining/hlchunk.nvim",
		event = { "UIEnter" },
		config = function()
			require("hlchunk").setup({
				blank = {
					enable = false,
				},
				indent = {
					use_treesitter = true,
				},
				line_num = {
					use_treesitter = true,
				},
			})
		end,
	},
}
