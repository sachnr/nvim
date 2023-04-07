local keys = require("keys")
return {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"mfussenegger/nvim-jdtls",
	"LudoPinelli/comment-box.nvim",
	"famiu/bufdelete.nvim",

	{
		"anuvyklack/windows.nvim",
		lazy = false,
		dependencies = {
			"anuvyklack/middleclass",
			{ "anuvyklack/animation.nvim", enabled = false },
		},
		keys = keys.windows,
		config = function()
			vim.o.winwidth = 5
			vim.o.equalalways = false
			require("windows").setup({
				animation = { enable = false },
				ignore = {
					filetype = { "NvimTree", "lspsagaoutline", "undotree" },
				},
			})
		end,
	},
}
