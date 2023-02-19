local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local window_hint = [[
╔╗ ┬ ┬┌─┐┌─┐┌─┐┬─┐╦  ┬┌┐┌┌─┐    _h_: prev               _l_: next
╠╩╗│ │├┤ ├┤ ├┤ ├┬┘║  ││││├┤     _H_: move prev          _L_: move next
╚═╝└─┘└  └  └─┘┴└─╩═╝┴┘└┘└─┘    _oe_: SortByExtension   _od_: SortByDirectory
 _<Esc>_, _q_: exit                 #: goto buffer #      _d_: close buffer
]]

Hydra({
	name = "Bufferline",
	hint = window_hint,
	config = {
		invoke_on_body = true,
		border = "rounded",
		hint = {
			position = "top",
			border = "rounded",
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
		{ "1", cmd("BufferLineGoToBuffer 1"), { desc = false } },
		{ "2", cmd("BufferLineGoToBuffer 2"), { desc = false } },
		{ "3", cmd("BufferLineGoToBuffer 3"), { desc = false } },
		{ "4", cmd("BufferLineGoToBuffer 4"), { desc = false } },
		{ "5", cmd("BufferLineGoToBuffer 5"), { desc = false } },
		{ "6", cmd("BufferLineGoToBuffer 6"), { desc = false } },
		{ "7", cmd("BufferLineGoToBuffer 7"), { desc = false } },
		{ "8", cmd("BufferLineGoToBuffer 8"), { desc = false } },
		{ "9", cmd("BufferLineGoToBuffer 9"), { desc = false } },
		{
			"d",
			function()
				require("bufdelete").bufdelete(0, true)
			end,
			{ desc = "close" },
		},
		{ "od", cmd("BufferLineSortByDirectory"), { desc = "by directory" } },
		{ "oe", cmd("BufferLineSortByExtension"), { desc = "by language" } },
		{ "<Esc>", nil, { exit = true } },
		{ "q", nil, { exit = true } },
	},
})
