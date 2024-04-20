return {
	{
		"nvim-focus/focus.nvim",
		enabled = false,
		version = false,
		event = "VeryLazy",
		config = function()
			require("focus").setup({ commands = false, ui = { signcolumn = false } })

			local ignore_filetypes = {
				"undotree",
				"dapui_watches",
				"dapui_stacks",
				"dapui_scopes",
				"dapui_breakpoints",
				"dap-repl",
				"DiffviewFiles",
				"qf",
			}
			local ignore_buftypes = {
				"quickfix",
				"nofile",
				"prompt",
				"popup",
			}
			local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
			vim.api.nvim_create_autocmd("WinEnter", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
						vim.w.focus_disable = true
					else
						vim.w.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for BufType",
			})
			vim.api.nvim_create_autocmd("FileType", {
				group = augroup,
				callback = function(_)
					if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
						vim.b.focus_disable = true
					else
						vim.b.focus_disable = false
					end
				end,
				desc = "Disable focus autoresize for FileType",
			})
		end,
	},
}
