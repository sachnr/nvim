local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

local window_hint = [[
    Move      ^^  Size   ^^   ^^      Split
 ---------  ^^----------^^   ^^---------------
  ^ ^ ^ _k_ ^ ^   ^   _<C-k>_   ^   _s_: horizontally 
  ^ _h_ ^ ^ _l_   _<C-h>_ _<C-l>_   _v_: vertically
  ^ ^ ^ _j_ ^ ^   ^   _<C-j>_   ^   _d_: close
  ^ ^     ^^ ^^^  ^^        ^      _z_: maximize
  ^ _=_: equalize   ^        _o_: remain only
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
		{ "h", "<C-w>h" },
		{ "j", "<C-w>j" },
		{ "k", "<C-w>k" },
		{ "l", "<C-w>l" },
		{ "<C-h>", "<C-w>3<" },
		{ "<C-l>", "<C-w>3>" },
		{ "<C-k>", "<C-w>2+" },
		{ "<C-j>", "<C-w>2-" },
		{ "=", "<C-w>=", { desc = "equalize" } },
		{ "s", pcmd("split"), { exit = true, desc = "horizontal" } },
		{ "v", pcmd("vsplit"), { exit = true, desc = "vertical" } },
		{ "z", cmd("WindowsMaximize"), { exit = true, desc = "maximize" } },
		{ "o", "<C-w>o", { exit = true, desc = "remain only" } },
		{ "d", pcmd("close", "E444"), { desc = "close window" } },
		{ "q", nil, { exit = true, desc = false } },
		{ "<Esc>", nil, { exit = true, desc = false } },
	},
})
