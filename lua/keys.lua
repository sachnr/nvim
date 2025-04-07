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

return M
