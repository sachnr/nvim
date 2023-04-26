return {
	{
		"rmagatti/auto-session",
		lazy = false,
    enabled = false,
		-- cmd = { "SaveSession", "RestoreSession", "DeleteSession", "Autosession", "RestoreSessionFromFile" },
		config = function()
			vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Downloads", "~/Documents", "/" },
				cwd_change_handling = {
					post_cwd_changed_hook = function()
						require("lualine").refresh()
					end,
				},
			})
		end,
	},
}
