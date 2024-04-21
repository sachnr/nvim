---@diagnostic disable: missing-fields
local keys = require("keys")

return {
	{
		"folke/zen-mode.nvim",
		keys = keys.zenmode(),
		config = true,
	},

	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup({
				preview = {
					auto_preview = false,
				},
			})
		end,
	},
}
