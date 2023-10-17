return {
	{
		"nvim-neorg/neorg",
		-- ft = "norg",
        lazy = false,
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Documents/notes",
							},
							index = "index.norg",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
					["core.integrations.treesitter"] = {
						config = {
							configure_parsers = true,
							install_parsers = true,
						},
					},
					["core.integrations.nvim-cmp"] = {},
					["core.qol.todo_items"] = {},
				},
			})
		end,
	},

	{
		"lervag/vimtex",
		ft = "norg",
		enabled = true,
	},
}
