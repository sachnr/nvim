return {
	{
		"j-hui/fidget.nvim",
		lazy = false,
		config = function()
			require("fidget").setup({
				notification = {
					window = {
						winblend = 0,
					},
				},
			})
		end,
	},
}
