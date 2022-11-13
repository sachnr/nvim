local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
	return
end

require("base46").load_highlight("scrollbar")

scrollbar.setup({
	set_highlights = false,
	handle = {
		hide_if_all_visible = false, -- Hides handle if all lines are visible
	},
	marks = {
		Search = {
			text = { "▁" },
		},
		Error = {
			text = { "" },
		},
		Warn = {
			text = { "" },
		},
		Info = {
			text = { "" },
		},
		Hint = {
			text = { "" },
		},
		Misc = {
			text = { "" },
		},
		GitDelete = {
			text = "┆",
		},
	},
})
