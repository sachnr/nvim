local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local window_hint = [[
    Move      ^^  Size   ^^  ^^ Shift   ^^   Tabs  ^^          Split
 ---------  ^^----------^^  ^^---------^^  -------------  ^^---------------
  ^ ^ ^ _k_ ^ ^   ^   _<C-k>_   ^    ^ ^ ^ _K_ ^ ^    _tc_: tabclose   _S_: horizontally 
  ^ _h_ ^ ^ _l_   _<C-h>_ _<C-l>_    ^ _H_ ^ ^ _L_    _tn_: tabNext    _s_: vertically
  ^ ^ ^ _j_ ^ ^   ^   _<C-j>_   ^    ^ ^ ^ _J_ ^ ^    _tp_: tabPrev    _d_: close
  ^ ^     ^^ ^^^  ^^        ^              
  ^ _e_: equalize   ^_tt_: tabNew   _z_: maximize   _o_: remain only
  ^_<Esc>_, _q_ : exit     
]]

Hydra({
	name = "Windows",
	mode = { "n", "t" },
	hint = window_hint,
	config = {
		invoke_on_body = true,
		hint = {
			position = "middle",
			border = "single",
		},
	},
	body = "<leader>w",
	heads = {
		{ "h", cmd("wincmd h") },
		{ "j", cmd("wincmd j") },
		{ "k", cmd("wincmd k") },
		{ "l", cmd("wincmd l") },
		{ "<C-h>", "<C-w>3<" },
		{ "<C-l>", "<C-w>3>" },
		{ "<C-k>", "<C-w>2+" },
		{ "<C-j>", "<C-w>2-" },
		{ "H", "<C-w>H" },
		{ "L", "<C-w>L" },
		{ "K", "<C-w>K" },
		{ "J", "<C-w>J" },
		{ "e", "<C-w>=", { desc = "equalize" } },
		{ "S", pcmd("split"), { exit = true, desc = "horizontal" } },
		{ "s", pcmd("vsplit"), { exit = true, desc = "vertical" } },
		{ "tc", cmd("tabclose"), { exit = true, desc = "tabclose" } },
		{ "tn", cmd("tabNext"), { desc = "tabclose" } },
		{ "tp", cmd("tabPrev"), { desc = "tabclose" } },
		{ "tt", cmd("tabNew"), { exit = true, desc = "tabclose" } },
		{ "z", cmd("WindowsMaximize"), { exit = true, desc = "maximize" } },
		{ "o", "<C-w>o", { exit = true, desc = "remain only" } },
		{ "d", pcmd("close", "E444"), { desc = "close window" } },
		{ "q", nil, { exit = true, desc = false } },
		{ "<Esc>", nil, { exit = true, desc = false } },
	},
})
