return {
	{
		"nvim-neorg/neorg",
		ft = "norg",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.norg.concealer"] = {},
					["core.norg.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Documents/notes",
							},
						},
					},
					["core.norg.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.integrations.nvim-cmp"] = {},
				},
			})
		end,
	},
}
