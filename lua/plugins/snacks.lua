return {
	{
		"folke/snacks.nvim",
		keys = {
			{
				"<M-z>",
				mode = "n",
				function()
					local snacks = require("snacks")
					snacks.zen()
				end,
				desc = "zenmode",
			},
		},
		opts = {
			image = {},
			bigfile = {},
			zen = {},
		},
	},
}
