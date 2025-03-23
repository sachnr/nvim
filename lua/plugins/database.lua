return {
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
