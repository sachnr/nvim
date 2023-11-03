return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = { "kristijanhusak/vim-dadbod-completion" },
		cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
		end,
	},

	{
		"kristijanhusak/vim-dadbod-completion",
		ft = { "sql", "sqlite", "mysql" },
		dependencies = { "tpope/vim-dadbod" },
	},
}
