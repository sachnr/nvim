local present, wk = pcall(require, "which-key")

if not present then
	return
end

require("base46").load_highlight("whichkey")

local options = {

	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "  ", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},

	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},

	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},

	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},

	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

-- lazygit terminal
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "double",
	},
})

function _lazygit_toggle()
	lazygit:toggle()
end

-- Normal mode Mappings

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	-- Search
	t = {
		name = "Telescope/Search",
		p = { "<cmd> :Telescope projects <CR>", "projects" },
		f = { "<cmd> Telescope find_files <CR>", "find files" },
		a = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "find all" },
		w = { "<cmd> Telescope live_grep <CR>", "live grep" },
		b = { "<cmd> Telescope buffers <CR>", "find buffers" },
		m = { "<cmd> Telescope help_tags <CR>", "help page" },
		o = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
		l = { "<cmd> Telescope keymaps <CR>", "show keys" },
		t = { "<cmd> Telescope terms <CR>", "pick hidden term" },
		k = { "<cmd> Telescope marks <CR>", "Bookmarks" },
	},
	-- trouble
	e = {
		name = "Erorrs",
		e = { "<cmd> :TroubleToggle <CR>", "Toggle Errors" },
		r = { "<cmd> :TroubleRefresh <CR>", "Refresh Errors" },
	},
	-- Git
	g = {
		name = "Git",
		o = { "<cmd>Telescope git_status<cr>", "Telescope git status" },
		b = { "<cmd>Telescope git_branches<cr>", "Telescope git branches" },
		c = { "<cmd>Telescope git_commits<cr>", "Telescope git commits" },
		g = { "<cmd>lua _lazygit_toggle()<CR>", "LazyGit UI" },
	},
	-- lsp
	l = {
		name = "LSP",
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		n = { "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", "buf goto_next" },
		p = { "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", "buf goto_prev" },
		o = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostics open_float" },
		q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Buf setloclist" },
	},
	w = {
		name = "whichKey",
		a = {
			function()
				vim.cmd("WhichKey")
			end,
			"which-key all keymaps",
		},
		k = {
			function()
				local input = vim.fn.input("WhichKey: ")
				vim.cmd("WhichKey " .. input)
			end,
			"which-key query lookup",
		},
	},
	o = {
		name = "Dashboard/options",
		b = { "<cmd> :Alpha <CR>", "Open Dashboard" },
		s = { ":e $MYVIMRC | :cd %:p:h <CR>", "Settings/vimrc" },
		n = { "<cmd> set nu! <CR>", "toggle line number" },
		r = { "<cmd> set rnu! <CR>", "toggle relative number" },
	},
	-- debugger
	d = {
		name = "Debugger",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl Toggle" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "Dap UI Toggle" },
		t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
	},
	-- todo list
	-- a = {
	--   name = "Todo comments",
	--   n = { "<cmd>lua require('todo-comments').jump_next() <cr>", "Jumo Next" },
	--   p = { "<cmd>lua require('todo-comments').jump_prev() <cr>", "Jump Prev" },
	--   e = {
	--     "<cmd>lua  require('todo-comments').jump_next({keywords = { 'ERROR', 'WARNING' }}) <cr>",
	--     "Next Error/Warning",
	--   },
	-- },
	--
	-- java lsp
	j = {
		name = "Java nvim-jdtls extra",
		o = { "<cmd> lua require'jdtls'.organize_imports() <cr>", "Organize Imports" },
		v = { "<cmd>  lua require('jdtls').extract_variable() <cr>", "Extract Variable" },
		c = { "<cmd> lua require('jdtls').extract_constant() <cr>", "Extract Constant" },
		t = { "<cmd> lua require'jdtls'.test_nearest_method() <cr>", "Test Nearest Method" },
		T = { "<cmd> lua require'jdtls'.test_class() <cr>", "Test Class" },
		u = { "<cmd> JdtUpdateConfig <cr>", "Update Config" },
	},
}

-- Visual mode Mappings
local vopts = {
	mode = "v", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vmappings = {
	-- nvim-jdtls
	j = {
		name = "Java nvim-jdtls extra",
		v = { "<cmd> lua require('jdtls').extract_variable(true) <cr>", "Extract Variable" },
		c = { "<cmd> lua require('jdtls').extract_constant(true) <cr>", "Extract Constant" },
		m = { "<cmd> lua require('jdtls').extract_method(true) <cr>", "Extract Method" },
	},
}

wk.setup(options)
wk.register(mappings, opts)
wk.register(vmappings, vopts)
