M = {}

local set = vim.keymap.set
local opts = {
	silent = true,
	noremap = true,
}
local merge = function(table1, table2)
	return vim.tbl_deep_extend("force", table1, table2)
end

M.defaults = function()
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
	set("n", "<leader>cd", "<cmd> :cd %:p:h <CR>", merge(opts, { desc = "Change dir" }))
	vim.api.nvim_create_autocmd("FileType", {
		pattern = {
			"help",
			"qf",
			"lspinfo",
			"man",
			"quickfix",
			"checkhealth",
		},
		command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted 
        ]],
	})
end

M.neogen = function()
	return {
		{
			"<Leader>n",
			mode = "n",
			"<cmd> Neogen <CR>",
			desc = "generate docs",
		},
	}
end

M.toggleterm = function()
	return {
		{ "<F5>", mode = { "n", "t" }, "<cmd>ToggleTerm direction=vertical size=100<cr>", desc = "toggleterm" },
	}
end

M.hlslens = function()
	vim.api.nvim_set_keymap(
		"n",
		"n",
		[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
		opts
	)
	vim.api.nvim_set_keymap(
		"n",
		"N",
		[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
		opts
	)
	vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
	vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
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

M.harpoon = function()
	return {
		{
			"<M-h><M-m>",
			mode = "n",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "harpoon mark",
		},
		{
			"<M-h><M-l>",
			mode = "n",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "harpoon ui",
		},
		{ "<space>1", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = "goto 1" },
		{ "<space>2", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = "goto 2" },
		{ "<space>3", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = "goto 3" },
		{ "<space>4", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = "goto 4" },
		{ "<space>5", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", desc = "goto 5" },
	}
end

M.buffer_manager = function()
	return {
		{
			"<M-h><M-b>",
			mode = "n",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
			desc = "buffermanager ui",
		},
	}
end

M.nvim_tree = function()
	-- set("n", "<leader>1", "<cmd> NvimTreeFocus <CR>", opts)
	return {
		{ "<M-h><M-j>", mode = "n", "<cmd> NeoTreeFocusToggle <CR>", desc = "toggle neotree" },
	}
end

M.peek = function()
	return {
		{
			"<leader>bm",
			mode = "n",
			function()
				local peek = require("peek")
				if peek.is_open() then
					peek.close()
				else
					peek.open()
				end
			end,
			desc = "Markdown Peek",
		},
	}
end

M.windows = function()
	return {
		{ "<C-w>z", mode = "n", "<cmd> WindowsMaximize <CR>", desc = "Maximize" },
		{ "<C-w>_", mode = "n", "<cmd> WindowsMaximizeVertically <CR>", desc = "WindowsMaximizeVertically" },
		{ "<C-w>|", mode = "n", "<cmd> WindowsMaximizeHorizontally <CR>", desc = "WindowsMaximizeHorizontally" },
		{ "<C-w>=", mode = "n", "<cmd> WindowsEqualize <CR>", desc = "WindowsEqualize" },
	}
end

M.yanky = function()
	return {
		{ "y", mode = { "n", "x" }, "<Plug>(YankyYank)", desc = "Yanky Yank" },
		{ "p", mode = { "n", "x" }, "<Plug>(YankyPutAfter)", desc = "Yanky Put After" },
		{ "P", mode = { "n", "x" }, "<Plug>(YankyPutBefore)", desc = "Yanky Put Before" },
		{ "<c-n>", mode = "n", "<Plug>(YankyCycleForward)", desc = "Yanky Cycle Forward" },
		{ "<c-p>", mode = "n", "<Plug>(YankyCycleBackward)", desc = "Yanky Cycle Back" },
		{ "<leader>p", mode = { "n", "x" }, "<cmd> Telescope yank_history <CR>", desc = "Paste from Yanky" },
	}
end

M.whichKey_n = {
	d = {
		function()
			---@diagnostic disable-next-line: undefined-field
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
		l = { "<Cmd>lua require('comment-box').llbox(2)<CR>", "left aligned fixed size" },
		c = { "<Cmd>lua require('comment-box').lcbox(2)<CR>", "centered adapted box" },
		v = { "<Cmd>lua require('comment-box').cline(8)<CR>", "centered line" },
	},
	-- local server
	b = {
		name = "localhost",
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
