return {
	{
		"anuvyklack/hydra.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("plugins.hydra.telescope")
			require("plugins.hydra.git")
			require("plugins.hydra.windows")
			require("plugins.hydra.dap")
		end,
	},
}
