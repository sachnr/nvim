local Hydra = require("hydra")

local hint = [[
 _<F5>_:  Continue/Start     _b_: Breakpoint        _K_: Hover          _r_:  Repl
 _<F10>_: step over          _x_:  Terminate        ^ ^                 _u_: Toggle UI
 _<F11>_: step into          ^ ^                    _R_: Run Last
 _<F12>_: step out           ^ ^
 ^ ^                         _q_: exit
]]

local dap_hydra = Hydra({
	hint = hint,
	config = {
		color = "pink",
		invoke_on_body = true,
		hint = {
			position = "bottom",
			border = "single",
		},
	},
	name = "dap",
	mode = { "n", "x" },
	body = "<leader>d",
	heads = {
		{ "<F5>", ":lua require'dap'.continue()<CR>", { silent = true } },
		{ "<F10>", ":lua require'dap'.step_over()<CR>", { silent = true } },
		{ "<F11>", ":lua require'dap'.step_into()<CR>", { silent = true } },
		{ "<F12>", ":lua require'dap'.step_out()<CR>", { silent = true } },
		{ "b", ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true } },
		{ "r", ":require('dap').repl.open()<CR>", { silent = true } },
		{ "R", ":require('dap').run_last()<CR>", { silent = true } },
		{ "x", ":require'dap'.terminate()<CR>", { silent = true } },
		{ "u", ":lua require('dapui').toggle()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
		{ "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
		{ "q", nil, { exit = true, nowait = true } },
	},
})

Hydra.spawn = function(head)
	if head == "dap-hydra" then
		dap_hydra:activate()
	end
end