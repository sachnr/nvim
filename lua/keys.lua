M = {}

local set = vim.keymap.set
local opts = {
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}
local utils = require("utils")
local merge = require("utils").merge_tb

M.bufdelete = function()
	set("n", "<leader>q", function()
		require("bufdelete").bufdelete(0, true)
	end, merge(opts, { desc = "close buffer" }))
end

M.defaults = function()
	-- navigate within insert mode
	set("i", "<C-h>", "<left>", merge(opts, { desc = "move left" }))
	set("i", "<C-l>", "<Right>", merge(opts, { desc = "move right" }))
	set("i", "<C-j>", "<Down>", merge(opts, { desc = "move down" }))
	set("i", "<C-k>", "<Up>", merge(opts, { desc = "move up" }))
	set("i", "<C-c>", "<ESC>", { silent = true })
	-- remove highlight
	set("n", "<ESC>", "<cmd> noh <CR>", merge(opts, { desc = "no highlight" }))
	-- save
	set("n", "<C-s>", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- copy all
	set("n", "<leader>C", "<cmd> %y+ <CR>", merge(opts, { desc = "copy whole file" }))
	-- buffer
	set("n", "<Tab>", function()
		utils.goto_next_buffer()
	end, merge(opts, { desc = "next Buffer" }))
	set("n", "<S-Tab>", function()
		utils.goto_prev_buffer()
	end, merge(opts, { desc = "Prev Buffer" }))
end

M.lsp_attach = function(bufnr)
	local lsp_opts = merge(opts, { buffer = bufnr })
	set("n", "<leader>la", vim.lsp.buf.code_action, merge(lsp_opts, { desc = "code_action" }))
	set("n", "<leader>lr", vim.lsp.buf.references, merge(lsp_opts, { desc = "references" }))
	set("n", "K", vim.lsp.buf.hover, merge(lsp_opts, { desc = "hover" }))
	set("n", "<leader>lD", vim.lsp.buf.declaration, merge(lsp_opts, { desc = "declaration" }))
	set("n", "<leader>ld", vim.lsp.buf.definition, merge(lsp_opts, { desc = "definition" }))
	set("n", "<leader>li", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "implementation" }))
	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
end

M.nvim_tree = function()
	set("n", "<leader>n", "<cmd> NvimTreeToggle <CR>", opts)
	set("n", "<leader>1", "<cmd> NvimTreeFocus <CR>", opts)
end

M.peek = function()
	set("n", "<leader>bm", function()
		local peek = require("peek")
		if peek.is_open() then
			peek.close()
		else
			peek.open()
		end
	end, merge(opts, { desc = "Markdown Peek" }))
end

M.yanky = function()
	set({ "n", "x" }, "y", "<Plug>(YankyYank)")
	set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
	set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
	set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
	set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

	set("n", "<c-n>", "<Plug>(YankyCycleForward)")
	set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

	set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
	set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
	set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
	set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

	set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
	set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
	set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
	set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

	set("n", "<leader>p", "<cmd> Telescope yank_history <CR>", { desc = "Paste from Yanky" })
end

M.comment = function()
	set(
		"n",
		"<leader>/",
		"<cmd>lua require('Comment.api').toggle.linewise.current() <CR>",
		merge(opts, { desc = "toggle comment" })
	)
	set(
		"v",
		"<leader>/",
		"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
		merge(opts, { desc = "toggle comment" })
	)
end

M.whichKey_n = {
	-- Search
	t = {
		name = "Telescope/Search",
		s = { "<cmd> :Telescope current_buffer_fuzzy_find <CR>", "search in current buffer" },
		t = { "<cmd> :Telescope buffers <CR>", "active buffers" },
		m = { "<cmd> :Telescope marks <CR>", "Marks" },
		p = { "<cmd> :Telescope project <CR>", "project" },
		f = { "<cmd> Telescope find_files <CR>", "find files" },
		w = { "<cmd> Telescope live_grep <CR>", "live grep" },
		o = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
	},
	-- Git
	g = {
		name = "Git",
		o = { "<cmd>Telescope git_status<cr>", "Telescope git status" },
		b = { "<cmd>Telescope git_branches<cr>", "Telescope git branches" },
		c = { "<cmd>Telescope git_commits<cr>", "Telescope git commits" },
		g = { "<cmd>lua _gitui_toggle()<CR>", "LazyGit UI" },
	},
	-- windows
	w = {
		name = "window actions",
		v = { "<cmd> vsplit <cr>", "split vertical" },
		h = { "<cmd> split <cr>", "split horizontal" },
		a = { "<cmd> :Alpha <CR>", "Open Dashboard" },
		d = { "<cmd> cd%:h <CR>", "Change to Directory of Current file" },
		r = { "<cmd> set rnu! <CR>", "toggle relative number" },
	},
	-- lsp
	l = {
		name = "LSP",
		I = { "<cmd>LspInfo<cr>", "Info" },
		-- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		-- q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Buf setloclist" },
		e = { "<cmd> :TroubleToggle <CR>", "Toggle Errors" },
		E = { "<cmd> :TroubleRefresh <CR>", "Refresh Errors" },
	},
	-- debugger
	d = {
		name = "Debugger",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		B = { "<cmd> lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", "List Breakpoints" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
		O = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl Toggle" },
		l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
		u = { "<cmd>lua require'dapui'.toggle()<cr>", "Dap UI Toggle" },
		t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
		s = { "<cmd>lua require('osv').launch({ port = 8086 })<cr>", "Launch Lua Debugger Server" },
		d = { "<cmd>lua require('osv').run_this()<cr>", "Launch Lua Debugger" },
	},
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
	-- comment box
	c = {
		name = "Comment Box",
		l = { "<Cmd>lua require('comment-box').lbox(1)<CR>", "left aligned fixed size" },
		c = { "<Cmd>lua require('comment-box').accbox(1)<CR>", "centered adapted box" },
		v = { "<Cmd>lua require('comment-box').cline(1)<CR>", "centered line" },
	},
	-- local server
	b = {
		name = "localhost",
		s = { "<cmd> BrowserSync <CR>", "run browser-sync server" },
		o = { "<cmd> BrowserOpen <CR>", "strat server & preview current file" },
		p = { "<cmd> BrowserPreview <CR>", "preview current file with browser sync" },
		r = { "<cmd> BrowserRestart <CR>", "restart browser sync" },
		S = { "<cmd> Browserstop <CR>", "stop browser sync" },
	},
}

M.whichKey_v = {
	j = {
		name = "Java nvim-jdtls extra",
		v = { "<cmd> lua require('jdtls').extract_variable(true) <cr>", "Extract Variable" },
		c = { "<cmd> lua require('jdtls').extract_constant(true) <cr>", "Extract Constant" },
		m = { "<cmd> lua require('jdtls').extract_method(true) <cr>", "Extract Method" },
	},
	-- comment box
	c = {
		name = "Comment Box",
		l = { "<Cmd>lua require('comment-box').lbox(7)<CR>", "left aligned fixed size" },
		c = { "<Cmd>lua require('comment-box').accbox(3)<CR>", "centered adapted box" },
		v = { "<Cmd>lua require('comment-box').cline(7)<CR>", "centered line" },
	},
}

return M
