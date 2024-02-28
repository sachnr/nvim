return {
	{
		"nvim-neorg/neorg",
		-- ft = "norg",
		enabled = true,
		event = "VeryLazy",
		run = ":Neorg sync-parsers",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.keybinds"] = {
						config = {
							hook = function(keybinds)
								keybinds.remap_event(
									"norg",
									"n",
									"<localleader>nc",
									"core.looking-glass.magnify-code-block"
								)
							end,
						},
					},
					["core.tempus"] = {},
					["core.concealer"] = {
						config = {
							icon_preset = "diamond",
						},
					},
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
				},
			})
		end,
	},

	{
		"lervag/vimtex",
		enabled = false,
	},
}
