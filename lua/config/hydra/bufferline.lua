local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local window_hint = [[
╔╗ ┬ ┬┌─┐┌─┐┌─┐┬─┐╦  ┬┌┐┌┌─┐    _h_: prev               _l_: next
╠╩╗│ │├┤ ├┤ ├┤ ├┬┘║  ││││├┤     _H_: move prev          _L_: move next
╚═╝└─┘└  └  └─┘┴└─╩═╝┴┘└┘└─┘    _oe_: SortByExtension   _od_: SortByDirectory
 ^ ^ ^                             #: goto buffer #      _d_: close buffer
 _<Esc>_,_<Tab>_ _q_: exit          _<C-h>_: harpoon prev    _<C-l>_: harpoon next 
]]

Hydra({
	name = "Bufferline",
	hint = window_hint,
	config = {
		color = "red",
		invoke_on_body = true,
		hint = {
			position = "top",
			border = "single",
			offset = 1,
		},
	},
	mode = "n",
	body = "<Tab>",
	heads = {
		{ "h", cmd("BufferLineCyclePrev") },
		{ "l", cmd("BufferLineCycleNext"), { desc = "choose" } },
		{ "H", cmd("BufferLineMovePrev") },
		{ "L", cmd("BufferLineMoveNext"), { desc = "move" } },
		{ "1", cmd("BufferLineGoToBuffer 1"), { exit = true, desc = false } },
		{ "2", cmd("BufferLineGoToBuffer 2"), { exit = true, desc = false } },
		{ "3", cmd("BufferLineGoToBuffer 3"), { exit = true, desc = false } },
		{ "4", cmd("BufferLineGoToBuffer 4"), { exit = true, desc = false } },
		{ "5", cmd("BufferLineGoToBuffer 5"), { exit = true, desc = false } },
		{ "6", cmd("BufferLineGoToBuffer 6"), { exit = true, desc = false } },
		{ "7", cmd("BufferLineGoToBuffer 7"), { exit = true, desc = false } },
		{ "8", cmd("BufferLineGoToBuffer 8"), { exit = true, desc = false } },
		{ "9", cmd("BufferLineGoToBuffer 9"), { exit = true, desc = false } },
		{
			"d",
			function()
				require("bufdelete").bufdelete(0, true)
			end,
			{ desc = "delbuff" },
		},
		{
			"<C-l>",
			function()
				require("harpoon.ui").nav_next()
			end,
			{ desc = "harpoon next" },
		},
		{
			"<C-h>",
			function()
				require("harpoon.ui").nav_prev()
			end,
			{ desc = "harpoon next" },
		},
		{ "od", cmd("BufferLineSortByDirectory"), { desc = "by directory" } },
		{ "oe", cmd("BufferLineSortByExtension"), { desc = "by language" } },
		{ "<Esc>", nil, { exit = true } },
		{ "q", nil, { exit = true } },
		{ "<Tab>", nil, { exit = true } },
	},
})
