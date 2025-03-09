return {
	{
		"nvimtools/none-ls.nvim",
		enabled = true,
		lazy = false,
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.cppcheck.with({
						extra_args = {
							"--language=cpp",
						},
					}),
				},
			})
		end,
	},
}
