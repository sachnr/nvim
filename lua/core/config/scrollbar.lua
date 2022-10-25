local status_ok, scrollbar = pcall(require, "scrollbar")
if not status_ok then
	return
end

require("base46").load_highlight("scrollbar")

scrollbar.setup({
	set_highlights = false,
})
