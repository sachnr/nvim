return {
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				shortcut_type = "letter",
				change_to_vcs_root = true,
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = " Update", group = "DiagnosticHint", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "DiagnosticInfo",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							desc = " pinned projects",
							group = "Directory",
							action = "Telescope project",
							key = "p",
						},
						{
							desc = " Old Files",
							group = "Directory",
							action = "Telescope oldfiles",
							key = "o",
						},
						{
							desc = " dotfiles",
							group = "DiagnosticWarn",
							action = "e $MYVIMRC | cd %:p:h",
							key = "d",
						},
					},
				},
				hide = {
					statusline = true,
					tabline = true,
					winbar = true,
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
