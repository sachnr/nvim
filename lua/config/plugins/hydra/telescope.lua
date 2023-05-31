local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd

local hint = [[
 ^ _o_: old files   _g_: live grep        _d_: diagnostics     ^
 ^  _p_: projects    _/_: search in file   _m_: marks           ^
 ^  _f_: files       _r_: registers        _t_: Buffers         ^
 ^                                                              ^
 ^  _h_: vim help    _c_: execute command  _O_: options         ^
 ^  _k_: keymaps     _;_: commands history _?_: search history  ^
 ^                                                              ^
 ^   _<Enter>_: Telescope  _q_: exit                            ^
]]

Hydra({
	name = "Telescope",
	hint = hint,
	config = {
		color = "teal",
		invoke_on_body = true,
		hint = {
			position = "middle",
			border = "single",
		},
	},
	mode = "n",
	body = "<Leader>t",
	heads = {
		{ "f", cmd("Telescope find_files") },
		{ "g", cmd("Telescope live_grep") },
		{ "o", cmd("Telescope oldfiles"), { desc = "recently opened files" } },
		{ "h", cmd("Telescope help_tags"), { desc = "vim help" } },
		{ "m", cmd("MarksListBuf"), { desc = "marks" } },
		{ "k", cmd("Telescope keymaps") },
		{ "O", cmd("Telescope vim_options") },
		{ "r", cmd("Telescope registers") },
		{ "d", cmd("Telescope diagnostics") },
		{ "p", cmd("Telescope project"), { desc = "projects" } },
		{ "/", cmd("Telescope current_buffer_fuzzy_find"), { desc = "search in file" } },
		{ "?", cmd("Telescope search_history"), { desc = "search history" } },
		{ ";", cmd("Telescope command_history"), { desc = "command-line history" } },
		{ "c", cmd("Telescope commands"), { desc = "execute command" } },
		{ "t", cmd("Telescope buffers"), { desc = "Buffers" } },
		{ "<Enter>", cmd("Telescope"), { exit = true, desc = "list all pickers" } },
		{ "q", nil, { exit = true, nowait = true } },
		{ "<Esc>", nil, { exit = true } },
	},
})
