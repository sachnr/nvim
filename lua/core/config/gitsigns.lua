local present, gitsigns = pcall(require, "gitsigns")

if not present then
	return
end

require("base46").load_highlight("git")

local options = {
	signs = {
		add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
	on_attach = function(bufnr)
		local map = vim.keymap.set
		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "Next hunk" })
		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true, desc = "prev hunk"})

		-- Actions
		map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", {desc = "Stage Hunk"})
		map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", {desc = "reset Hunk"})
		map("n", "<leader>gS", gitsigns.stage_buffer, {desc = "Stage buffer"})
		map("n", "<leader>gu", gitsigns.undo_stage_hunk, {desc = "Undo Stage Hunk"})
		map("n", "<leader>gR", gitsigns.reset_buffer, {desc = "reset buffer"})
		map("n", "<leader>gp", gitsigns.preview_hunk, {desc = "Preview Hunk"})
		map("n", "<leader>gb", function()
			gitsigns.blame_line({ full = true }, {desc = "Blame line"})
		end)
		map("n", "<leader>gB", gitsigns.toggle_current_line_blame, {desc = "Toggle current line blame"})
		map("n", "<leader>gd", gitsigns.diffthis, {desc = "Diff this"})
		map("n", "<leader>gD", function()
			gitsigns.diffthis("~")
		end, {desc = "diff this ~"})
		map("n", "<leader>gd", gitsigns.toggle_deleted, {desc = "Toggle Deleted"})

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", {desc = "Select Hunk"})
	end,
}

gitsigns.setup(options)
