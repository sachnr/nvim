return {
	{
		"anuvyklack/hydra.nvim",
		lazy = false,
		keys = require("keys").hydra,
		config = function()
			require("plugins.hydra.git")
			require("plugins.hydra.windows")
			require("plugins.hydra.dap")
		end,
	},
}
