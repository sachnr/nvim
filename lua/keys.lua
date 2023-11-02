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
	-- center
	set("n", "<C-u>", "<C-u>zz", opts)
	set("n", "<C-d>", "<C-d>zz", opts)
	-- Don't copy the replaced text after pasting in visual mode
	set("x", "<p>", 'p:let @+=@0<CR>:let @"=@0<CR>', opts)
	-- remove highlight
	set("n", "<ESC>", "<cmd> noh <CR>", merge(opts, { desc = "no highlight" }))
	-- save
	set("n", "<space>s", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- set("n", "<C-s>", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- d
	set("i", "<C-c>", "<ESC>", merge(opts, { desc = "Esc" }))
	-- copy all
	set("n", "<leader>C", "<cmd> %y+ <CR>", merge(opts, { desc = "copy whole file" }))
	set("n", "<leader>cd", "<cmd> :cd %:p:h <CR>", merge(opts, { desc = "Change dir" }))
	-- move visual chunks
	set("v", "<M-j>", ":m '>+1<CR>gv=gv")
	set("v", "<M-k>", ":m '<-2<CR>gv=gv")
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

M.ncmpcpp = function()
	local Terminal = require("toggleterm.terminal").Terminal

	local ncmpcpp = Terminal:new({
		cmd = "ncmpcpp",
		hidden = true,
		direction = "float",
		float_opts = {
			border = "single",
		},
	})

	set("n", "<leader>m", function()
		ncmpcpp:toggle()
	end, merge(opts, { desc = "Music Player" }))
end

M.telescope = function()
	return {
		{ "<Leader>tf", mode = "n", "<cmd> Telescope find_files <CR>", desc = "find files" },
		{ "<Leader>tg", mode = "n", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
		{ "<Leader>to", mode = "n", "<cmd> Telescope oldfiles <CR>", desc = "live grep" },
		{ "<Leader>tu", mode = "n", "<cmd> silent! %foldopen! | UndotreeToggle <CR>", desc = "UndotreeToggle" },
		{ "<Leader>t/", mode = "n", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "search in file" },
	}
end

M.neogen = function()
	return {
		{
			"<Leader>ng",
			mode = "n",
			"<cmd> Neogen <CR>",
			desc = "generate docs",
		},
	}
end

M.trouble = function()
	return {
		{
			"<Leader>E",
			mode = "n",
			"<cmd> Trouble <CR>",
			desc = "trouble",
		},
	}
end

M.toggleterm = function()
	return {
		{ "<F2>", mode = { "n", "t" }, "<cmd>ToggleTerm direction=vertical size=90<cr>", desc = "toggleterm" },
	}
end

M.zenmode = function()
	return {
		{
			"<M-z>",
			mode = "n",
			function()
				require("zen-mode").toggle({
					window = {
						width = 0.65,
					},
				})
			end,
			desc = "zenmode",
		},
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
M.lsp_attach = function(bufnr)
	set("n", "<space>e", vim.diagnostic.open_float, merge(opts, { desc = "diagnostic float" }))
	set("n", "[d", vim.diagnostic.goto_prev, merge(opts, { desc = "diagnostic goto prev" }))
	set("n", "]d", vim.diagnostic.goto_next, merge(opts, { desc = "diagnostic goto next" }))
	-- set("n", "<leader>lq", vim.diagnostic.setloclist, merge(opts, { desc = "diagnostic setlocklist" }))
	local lsp_opts = merge(opts, { buffer = bufnr })
	-- set("n", "ga", vim.lsp.buf.code_action, merge(lsp_opts, { desc = "code_action" }))
	set("n", "ga", '<cmd>lua require("cosmic-ui").code_actions()<cr>', merge(lsp_opts, { desc = "code_action" }))
	set("v", "ga", '<cmd>lua require("cosmic-ui").range_code_actions()<cr>', merge(lsp_opts, { desc = "code_action" }))
	set("n", "gh", vim.lsp.buf.references, merge(lsp_opts, { desc = "goto references" }))
	-- set("n", "gr", vim.lsp.buf.rename, merge(lsp_opts, { desc = "lsp rename" }))
	set("n", "gr", '<cmd>lua require("cosmic-ui").rename()<cr>', merge(lsp_opts, { desc = "lsp rename" }))
	set("n", "K", vim.lsp.buf.hover, merge(lsp_opts, { desc = "hover" }))
	set("n", "gD", vim.lsp.buf.declaration, merge(lsp_opts, { desc = "goto declaration" }))
	set("n", "gd", vim.lsp.buf.definition, merge(lsp_opts, { desc = "goto definition" }))
	set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
	set("n", "<leader>ld", vim.lsp.buf.type_definition, merge(lsp_opts, { desc = "Type Definition" }))
end

-- lspsaga
-- M.lsp_attach = function(bufnr)
-- 	set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", merge(opts, { desc = "diagnostic float" }))
-- 	set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", merge(opts, { desc = "diagnostic goto prev" }))
-- 	set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", merge(opts, { desc = "diagnostic goto next" }))
-- 	set("n", "<leader>l", "<cmd>Lspsaga show_buf_diagnostics<CR>", merge(opts, { desc = "diagnostic buffer" }))
-- 	local lsp_opts = merge(opts, { buffer = bufnr })
-- 	set("n", "ga", "<cmd>Lspsaga code_action<CR>", merge(lsp_opts, { desc = "code_action" }))
-- 	set("n", "gr", function()
-- 		vim.lsp.buf.rename()
-- 	end, merge(lsp_opts, { desc = "Lsp Rename" }))
-- 	set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", merge(lsp_opts, { desc = "references" }))
-- 	set("n", "K", "<cmd>Lspsaga hover_doc<CR>", merge(lsp_opts, { desc = "hover doc" }))
-- 	set("n", "go", "<cmd>Lspsaga outline<CR>", merge(lsp_opts, { desc = "toggle outline" }))
-- 	set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", merge(lsp_opts, { desc = "goto definition" }))
-- 	set("n", "gT", "<cmd>Lspsaga goto_type_definition<CR>", merge(lsp_opts, { desc = "goto type definition" }))
-- 	set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
-- 	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
-- end

M.harpoon = function()
	return {
		{
			"<M-h><M-h>",
			mode = "n",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "harpoon mark",
		},
		{
			"<M-h><M-u>",
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
		{ "<space>6", "<cmd>lua require('harpoon.ui').nav_file(6)<CR>", desc = "goto 6" },
	}
end

M.buffer_manager = function()
	return {
		{
			"<M-j><M-j>",
			mode = "n",
			function()
				require("buffer_manager.ui").toggle_quick_menu()
			end,
			desc = "buffermanager ui",
		},
	}
end

M.oil = function()
	return {
		{ "<M-j><M-k>", mode = "n", "<Cmd> :Oil %:h <CR>", desc = "Open Oil" },
		{ "<M-j><M-l>", mode = "n", "<Cmd> :vsplit | Oil %:h <CR>", desc = "Open Oil in a vsplit" },
	}
end

M.files = function()
	return {
		{
			"<M-j><M-k>",
			mode = "n",
			function()
				local files = require("mini.files")
				files.open()
			end,
			desc = "Open Oil",
		},
	}
end

M.nvim_tree = function()
	-- set("n", "<leader>1", "<cmd> NvimTreeFocus <CR>", opts)
	return {
		{ "<M-j><M-k>", mode = "n", "<cmd> NeoTreeFocusToggle <CR>", desc = "toggle neotree" },
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

M.comment_box = function()
	return {
		{
			"<leader>cl",
			mode = { "n", "x" },
			"<Cmd>lua require('comment-box').lbox(7)<CR>",
			desc = "left aligned centered box",
		},
		{
			"<leader>cc",
			mode = { "n", "x" },
			"<Cmd>lua require('comment-box').accbox(3)<CR>",
			desc = "centered adapted box",
		},
		{ "<leader>cv", mode = { "n", "x" }, "<Cmd>lua require('comment-box').cline(7)<CR>", desc = "centered line" },
	}
end

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
