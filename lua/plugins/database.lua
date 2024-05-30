return {

	-- {
	-- 	"MattiasMTS/cmp-dbee",
	-- 	dependencies = {
	-- 		{ "kndndrj/nvim-dbee" },
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	lazy = false,
	-- 	build = function()
	-- 		require("dbee").install("curl")
	-- 	end,
	-- 	config = function()
	-- 		require("dbee").setup(--[[optional config]])
	-- 	end,
	-- },

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"kristijanhusak/vim-dadbod-completion",
			"tpope/vim-dadbod",
		},
		cmd = { "DBUI" },
		config = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},
}
