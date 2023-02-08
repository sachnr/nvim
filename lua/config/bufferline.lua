local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local ok, base46 = pcall(require, "base46")
if not ok then
	return
end

local options = {
	mode = "buffers",
	numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
	close_command = function()
		require("bufdelete").bufdelete(0, true)
	end,
	right_mouse_command = "vert sbuffer %d",
	left_mouse_command = "buffer %d",
	middle_mouse_command = nil,
	indicator = {
		icon = "▎",
		style = "underline", -- 'icon' | 'underline' | 'none',
	},
	buffer_close_icon = "",
	modified_icon = "●",
	close_icon = "",
	left_trunc_marker = " ",
	right_trunc_marker = " ",
	max_name_length = vim.o.columns * 2 / 3,
	max_prefix_length = vim.o.columns * 2 / 3,
	truncate_names = true,
	tab_size = 18,
	diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
	diagnostics_update_in_insert = false,
	custom_filter = function(buf_number, buf_numbers)
		if vim.fn.bufname(buf_number) ~= "[dap-repl]" then
			return true
		end
	end,
	offsets = {
		{
			filetype = "NvimTree",
			-- text = "File Explorer",
			-- text_align = "center", -- "left" | "center" | "right"
			-- highlight = "BufferlineFill",
			separator = true,
			padding = 1,
		},
	},
	color_icons = true,
	show_buffer_icons = true,
	show_buffer_close_icons = true,
	show_buffer_default_icon = true,
	show_close_icon = true,
	show_tab_indicators = true,
	show_duplicate_prefix = true,
	persist_buffer_sort = false,
	separator_style = "thick", --"slant" | "thick" | "thin" | "padded_slant" { 'any', 'any' },
	enforce_regular_tabs = true,
	always_show_bufferline = false,
	-- hover = {
	--   enabled = true,
	--   delay = 200,
	--   reveal = { "close" },
	-- },
}

bufferline.setup({
	options = options,
})
