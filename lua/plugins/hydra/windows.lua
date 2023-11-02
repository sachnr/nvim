local Hydra = require("hydra")
local cmd = require("hydra.keymap-util").cmd
local pcmd = require("hydra.keymap-util").pcmd

Hydra({
	name = "moveWindows",
	mode = "n",
	body = "<C-w>m",
	config = {
        color = "pink",
		invoke_on_body = true,
	},
	heads = {
		{ "H", "<C-w>H" },
		{ "L", "<C-w>L" },
		{ "K", "<C-w>K" },
		{ "J", "<C-w>J" },
	},
})

Hydra({
	name = "resizeWindows",
	mode = "n",
	body = "\\",
	config = {
        color = "pink",
		invoke_on_body = true,
	},
	heads = {
		{ "<C-h>", "<C-w>3>" },
		{ "<C-l>", "<C-w>3<" },
		{ "<C-k>", "<C-w>2-" },
		{ "<C-j>", "<C-w>2+" },
		{ "e", "<C-w>=", { desc = "equalize" } },
		{ "s", pcmd("split"), { exit = true, desc = "horizontal" } },
		{ "v", pcmd("vsplit"), { exit = true, desc = "vertical" } },
	},
})
