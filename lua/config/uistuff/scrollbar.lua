local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
	return
end

scrollbar.setup({
	set_highlights = false,
	handle = {
		hide_if_all_visible = true, -- Hides handle if all lines are visible
	},
	excluded_filetypes = {
		"prompt",
		"TelescopePrompt",
		"noice",
		"NvimTree",
	},
	handlers = {
		cursor = false,
		diagnostic = true,
		gitsigns = false, -- Requires gitsigns
		handle = true,
		search = true, -- Requires hlslens
	},
	marks = {
		Search = {
			text = { "" },
		},
		Error = {
			text = { "" },
		},
	},
})
