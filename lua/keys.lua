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
	-- quickfixlist
	vim.keymap.set("n", "<leader>j", "<cmd>cnext<CR>zz")
	vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")
	-- save
	set("n", "<space>s", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- set("n", "<C-s>", "<cmd> w <CR>", merge(opts, { desc = "save buffer" }))
	-- d
	set("i", "<C-c>", "<ESC>", opts)
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

M.fzflua = function()
	return {
		{ "<Leader>tf", mode = "n", "<cmd> FzfLua files <CR>", desc = "find files" },
		{ "<Leader>tg", mode = "n", "<cmd> FzfLua live_grep <CR>", desc = "live grep" },
		{ "<Leader>to", mode = "n", "<cmd> FzfLua oldfiles <CR>", desc = "live grep" },
		{ "<Leader>tu", mode = "n", "<cmd> silent! %foldopen! | UndotreeToggle <CR>", desc = "UndotreeToggle" },
		{ "<Leader>t/", mode = "n", "<cmd> FzfLua blines <CR>", desc = "search in file" },
	}
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
	set("n", "ga", vim.lsp.buf.code_action, merge(lsp_opts, { desc = "code_action" }))
	-- set("n", "ga", "<cmd> FzfLua lsp_code_actions <cr>", merge(lsp_opts, { desc = "code_action" }))
	set("n", "gh", vim.lsp.buf.references, merge(lsp_opts, { desc = "goto references" }))
	set("n", "gr", vim.lsp.buf.rename, merge(lsp_opts, { desc = "lsp rename" }))
	set("n", "K", vim.lsp.buf.hover, merge(lsp_opts, { desc = "hover" }))
	set("n", "gD", vim.lsp.buf.declaration, merge(lsp_opts, { desc = "goto declaration" }))
	set("n", "gd", vim.lsp.buf.definition, merge(lsp_opts, { desc = "goto definition" }))
	set("n", "gi", vim.lsp.buf.implementation, merge(lsp_opts, { desc = "goto implementation" }))
	set("n", "<C-k>", vim.lsp.buf.signature_help, merge(lsp_opts, { desc = "signature_help" }))
	set("n", "<leader>ld", vim.lsp.buf.type_definition, merge(lsp_opts, { desc = "Type Definition" }))
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
			"<Cmd>lua require('comment-box').lcbox(3)<CR>",
			desc = "centered adapted box",
		},
		{ "<leader>cv", mode = { "n", "x" }, "<Cmd>lua require('comment-box').cline(7)<CR>", desc = "centered line" },
	}
end

M.oil = function()
	return {
		{
			"<M-j><M-k>",
			mode = "n",
			"<cmd> Oil <CR>",
			desc = "Open Oil",
		},
	}
end

M.git = function()
	return {
		{
			"<leader>gg",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local lazygit = Terminal:new({
					cmd = "lazygit",
					dir = "git_dir",
					hidden = true,
					direction = "float",
					float_opts = {
						border = "single",
					},
				})
				lazygit:toggle()
			end,
			{ desc = "lazygit" },
		},
		{ "<leader>gb", "<cmd> lua require('gitsigns').blame_line <cr>", { desc = "git blame" } },
		{ "<leader>gd", "<cmd> silent! %foldopen! | DiffviewOpen | wincmd = <CR>", { desc = "git diff" } },
		{ "<leader>gh", "<cmd> DiffviewFileHistory<CR>", { desc = "git history" } },
	}
end

return M
