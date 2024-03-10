return {
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		dependencies = "MunifTanjim/nui.nvim",
		opts = {
			select = {
				backend = { "nui", "builtin" },
			},
		},
	},
}
