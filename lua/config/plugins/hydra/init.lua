return {
	{
		"anuvyklack/hydra.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("config.plugins.hydra.telescope")
			require("config.plugins.hydra.git")
			require("config.plugins.hydra.windows")
			require("config.plugins.hydra.dap")
		end,
	},
}
