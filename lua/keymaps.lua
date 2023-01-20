local buffer = require("buff")

local Mappings = {
	-- =========================================================
	-- ===================== Insert mode =======================
	-- =========================================================
	i = {
		-- navigate within insert mode
		["<C-h>"] = { "<Left>", "move left" },
		["<C-l>"] = { "<Right>", "move right" },
		["<C-j>"] = { "<Down>", "move down" },
		["<C-k>"] = { "<Up>", "move up" },
		["<C-c>"] = { "<ESC>" },
	},

	-- =========================================================
	-- ===================== normal mode =======================
	-- =========================================================
	n = {
		["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },
		["<C-d>"] = { "<C-d>zz" },
		["<C-u>"] = { "<C-u>zz" },
		-- switch between windows
		["<C-h>"] = { "<C-w>h", "window left" },
		["<C-l>"] = { "<C-w>l", "window right" },
		["<C-j>"] = { "<C-w>j", "window down" },
		["<C-k>"] = { "<C-w>k", "window up" },
		-- ["<C-h>"] = { "<cmd> FocusSplitLeft <CR>", "window left" },
		-- ["<C-l>"] = { "<cmd> FocusSplitRight <CR>", "window right" },
		-- ["<C-j>"] = { "<cmd> FocusSplitDown <CR>", "window down" },
		-- ["<C-k>"] = { "<cmd> FocusSplitUp <CR>", "window up" },
		-- Resize with arrows
		["<C-Up>"] = { ":resize -2<CR>", "Resize Up" },
		["<C-Down>"] = { ":resize +2<CR>", "Resize down" },
		["<C-Right>"] = { ":vertical resize -2<CR>", "Resize left" },
		["<C-Left>"] = { ":vertical resize +2<CR>", "Resize right" },
		-- save
		["<C-s>"] = { "<cmd> w <CR>", "save file" },
		-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
		-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
		-- empty mode is same as using <cmd> :map
		-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		-- split vertical or horizontal
		["<leader>v"] = { "<cmd> :vsplit <CR>", "split vertical" },
		["<leader>h"] = { "<cmd> :split <CR>", "split horizontal" },
		-- formatter
		["<leader>f"] = { "<cmd> :Format <CR>", "formatter" },
		-- nvterm
		["<leader>`"] = { "<Cmd> :ToggleTerm <CR>", "toggle horizontal term" },
		-- bufferline
		-- ["<Bslash>"] = { " <Cmd> BufferLinePick <CR>", "Pick Buffer" },
		-- ["<TAB>"] = { " <Cmd> BufferLineCycleNext <CR>", "Next Buffer" },
		-- ["<S-Tab>"] = { " <Cmd> BufferLineCyclePrev <CR>", "Prev Buffer" },
		["<TAB>"] = {
			function()
				buffer.goto_next_buffer()
			end,
			"Next Buffer",
		},
		["<S-Tab>"] = {
			function()
				buffer.goto_prev_buffer()
			end,
			"Prev Buffer",
		},
		["<leader>q"] = {
			function()
				require("bufdelete").bufdelete(0, true)
			end,
			"Close Buffer",
		},
		["<leader>n"] = { "<cmd> enew <CR>", "new buffer" },
		-- nvimtree
		["<C-`>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
		["<leader>1"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
		-- copy all
		["<leader>C"] = { "<cmd> %y+ <CR>", "copy whole file" },
		-- indent blankline
		["gc"] = {
			function()
				local ok, start = require("indent_blankline.utils").get_current_context(
					vim.g.indent_blankline_context_patterns,
					vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd([[normal! _]])
				end
			end,
			"Jump to current_context",
		},
		-- comment
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"toggle comment",
		},
	},
	-- =========================================================
	-- ===================== visual mode =======================
	-- =========================================================
	v = {
		["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		-- comment
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"toggle comment",
		},
	},
	x = {
		["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
	},

	-- =========================================================
	-- ==================== terminal mode ======================
	-- =========================================================
	t = {
		-- toggle terminal (terminal mode)
		["<leader>`"] = { "<Cmd> :ToggleTerm <CR>", "toggle horizontal term" },
		["<S-n>"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
	},
}

local modes = {
	i = "i",
	n = "n",
	v = "v",
	x = "x",
	t = "t",
}

local opts = {
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

for mode, table in pairs(Mappings) do
	local modestr = modes[mode]
	for key, value in pairs(table) do
		local options = vim.tbl_deep_extend("force", opts, value.opts or {})
		options.desc = value[2]
		vim.keymap.set(modestr, key, value[1], options)
	end
end
