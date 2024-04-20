return {
	{
		"nvimtools/none-ls.nvim",
		enabled = false,
		lazy = false,
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.eslint,
				},
			})
		end,
	},
}
