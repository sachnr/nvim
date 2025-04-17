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
			animate = {
				duration = 20, -- ms per step
				easing = "linear",
				fps = 60, -- frames per second. Global setting for all animations
			},
		},
	},
}
