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
	set("i", "<C-c>", "<ESC>")
	-- center
	set("n", "<C-u>", "<C-u>zz", opts)
	set("n", "<C-d>", "<C-d>zz", opts)
	-- Don't copy the replaced text after pasting in visual mode
	-- set("x", "<p>", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)
	-- remove highlight
	set("n", "<ESC>", "<cmd> noh <CR>", merge(opts, { desc = "no highlight" }))
	-- save
	set("n", "<C-s>", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- copy all
	set("n", "<leader>C", "<cmd> %y+ <CR>", merge(opts, { desc = "copy whole file" }))
	-- harpoon
	set("n", "gh", function()
		require("harpoon.ui").toggle_quick_menu()
	end, merge(opts, { desc = "harpoon ui" }))
	-- buffer
	-- set("n", "<Tab>", function()
	-- 	utils.goto_next_buffer()
	-- end, merge(opts, { desc = "next Buffer" }))
	-- set("n", "<S-Tab>", function()
	-- 	utils.goto_prev_buffer()
	-- end, merge(opts, { desc = "Prev Buffer" }))
	--
	-- for i = 1, 9 do
	-- 	set("n", ("<Leader>%s"):format(i), function()
	-- 		utils.goto_buffer(i)
	-- 	end, { silent = true })
	-- end
end

-- -- normal
-- M.lsp_attach = function(bufnr)
-- 	set("n", "<space>e", vim.diagnostic.open_float, merge(opts, { desc = "diagnostic float" }))
-- 	set("n", "[d", vim.diagnostic.goto_prev, merge(opts, { desc = "diagnostic goto prev" }))
-- 	set("n", "]d", vim.diagnostic.goto_next, merge(opts, { desc = "diagnostic goto next" }))
-- 	set("n", "<leader>lq", vim.diagnostic.setloclist, merge(opts, { desc = "diagnostic setlocklist" }))
-- 	local lsp_opts = merge(opts, { buffer = bufnr })
-- 	set("n", "ga", vim.lsp.buf.code_action, merge(lsp_opts, { desc = "code_action" }))
-- 	set("n", "gr", vim.lsp.buf.references, merge(lsp_opts, { desc = "goto references" }))
-- 	set("n", "K", vim.lsp.buf.hover, merge(lsp_opts, { desc = "hover" }))
-- 	set("n", "gD", vim.lsp.buf.declaration, merge(lsp_opts, { desc = "goto declaration" }))
-- 	set("n", "gd", vim.lsp.buf.definition, merge(lsp_opts, { desc = "goto definition" }))
-- 	set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
-- 	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
-- 	set("n", "<leader>ld", vim.lsp.buf.type_definition, merge(lsp_opts, { desc = "Type Definition" }))
-- end

-- lspsaga
M.lsp_attach = function(bufnr)
	set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", merge(opts, { desc = "diagnostic float" }))
	set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", merge(opts, { desc = "diagnostic goto prev" }))
	set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", merge(opts, { desc = "diagnostic goto next" }))
	set("n", "<leader>l", "<cmd>Lspsaga show_buf_diagnostics<CR>", merge(opts, { desc = "diagnostic buffer" }))
	local lsp_opts = merge(opts, { buffer = bufnr })
	set("n", "ga", "<cmd>Lspsaga code_action<CR>", merge(lsp_opts, { desc = "code_action" }))
	set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", merge(lsp_opts, { desc = "references" }))
	set("n", "K", "<cmd>Lspsaga hover_doc<CR>", merge(lsp_opts, { desc = "hover doc" }))
	set("n", "go", "<cmd>Lspsaga outline<CR>", merge(lsp_opts, { desc = "toggle outline" }))
	set("n", "gD", "<cmd>Lspsaga goto_definition<CR>", merge(lsp_opts, { desc = "goto definition" }))
	set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", merge(lsp_opts, { desc = "peek definition" }))
	set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", merge(lsp_opts, { desc = "peek type definition" }))
	set("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", merge(lsp_opts, { desc = "goto type definition" }))
	set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
end

M.nvim_tree = function()
	set("n", "<leader>n", "<cmd> NvimTreeToggle <CR>", opts)
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

M.windows = function()
	set("n", "<C-w>z", "<cmd> WindowsMaximize <CR>", merge(opts, { desc = "copy whole file" }))
	set("n", "<C-w>_", "<cmd> WindowsMaximizeVertically <CR>", merge(opts, { desc = "WindowsMaximizeVertically" }))
	set("n", "<C-w>|", "<cmd> WindowsMaximizeHorizontally <CR>", merge(opts, { desc = "WindowsMaximizeHorizontally" }))
	set("n", "<C-w>=", "<cmd> WindowsEqualize <CR>", merge(opts, { desc = "WindowsEqualize" }))
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
	-- t = {
	-- 	name = "Telescope/Search",
	-- 	s = { "<cmd> :Telescope current_buffer_fuzzy_find <CR>", "search in current buffer" },
	-- 	t = { "<cmd> :Telescope buffers <CR>", "active buffers" },
	-- 	m = { "<cmd> :Telescope marks <CR>", "Marks" },
	-- 	p = { "<cmd> :Telescope project <CR>", "project" },
	-- 	f = { "<cmd> Telescope find_files <CR>", "find files" },
	-- 	w = { "<cmd> Telescope live_grep <CR>", "live grep" },
	-- 	o = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
	-- },
	-- Git
	-- g = {
	-- name = "Git",
	-- o = { "<cmd>Telescope git_status<cr>", "Telescope git status" },
	-- b = { "<cmd>Telescope git_branches<cr>", "Telescope git branches" },
	-- c = { "<cmd>Telescope git_commits<cr>", "Telescope git commits" },
	-- g = { "<cmd>lua _gitui_toggle()<CR>", "LazyGit UI" },
	-- },
	-- opts
	-- w = {
	-- 	name = "Options",
	-- 	a = { "<cmd> :Alpha <CR>", "Open Dashboard" },
	-- 	d = { "<cmd> cd%:h <CR>", "Change to Directory of Current file" },
	-- },
	-- lsp
	-- l = {
		-- name = "LSP",
		-- I = { "<cmd>LspInfo<cr>", "Info" },
		-- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		-- q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Buf setloclist" },
		-- e = { "<cmd> :TroubleToggle <CR>", "Toggle Errors" },
		-- E = { "<cmd> :TroubleRefresh <CR>", "Refresh Errors" },
	-- },
	d = {
		function()
			require("hydra").spawn("dap-hydra")
		end,
		"[Hydra] dap",
	},
	-- debugger
	-- d = {
	-- 	name = "Debugger",
	-- 	b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
	-- 	B = { "<cmd> lua require'telescope'.extensions.dap.list_breakpoints{}<cr>", "List Breakpoints" },
	-- 	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	-- 	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
	-- 	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
	-- 	O = { "<cmd>lua require'dap'.step_out()<cr>", "Step out" },
	-- 	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl Toggle" },
	-- 	l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
	-- 	u = { "<cmd>lua require'dapui'.toggle()<cr>", "Dap UI Toggle" },
	-- 	t = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
	-- 	s = { "<cmd>lua require('osv').launch({ port = 8086 })<cr>", "Launch Lua Debugger Server" },
	-- 	d = { "<cmd>lua require('osv').run_this()<cr>", "Launch Lua Debugger" },
	-- },
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

M.gitsigns = function(gitsigns)
	set("n", "]c", function()
		if vim.wo.diff then
			return "]c"
		end
		vim.schedule(function()
			gitsigns.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "Next hunk" })
	set("n", "[c", function()
		if vim.wo.diff then
			return "[c"
		end
		vim.schedule(function()
			gitsigns.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "prev hunk" })
	set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
	set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "reset Hunk" })
	set("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
	set("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
	set("n", "<leader>gR", gitsigns.reset_buffer, { desc = "reset buffer" })
	set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
	set("n", "<leader>gb", function()
		gitsigns.blame_line({ full = true }, { desc = "Blame line" })
	end)
	set("n", "<leader>gB", gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
	set("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
	set("n", "<leader>gD", function()
		gitsigns.diffthis("~")
	end, { desc = "diff this ~" })
	set("n", "<leader>gd", gitsigns.toggle_deleted, { desc = "Toggle Deleted" })
	set({ "o", "x" }, "gh", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
end

return M
