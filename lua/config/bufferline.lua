local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local ok, base46 = pcall(require, "base46")
if not ok then
	return
end

local options = {
	mode = "buffers", -- set to "tabs" to only show tabpages instead
	numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
	close_command = function()
		require("bufdelete").bufdelete(0, true)
	end, -- can be a string | function, see "Mouse actions"
	right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
	left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
	middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
	indicator = {
		icon = "▎", -- this should be omitted if indicator style is not 'icon'
		style = "underline", -- 'icon' | 'underline' | 'none',
	},
	buffer_close_icon = "",
	modified_icon = "●",
	close_icon = "",
	left_trunc_marker = " ",
	right_trunc_marker = " ",
	--- name_formatter can be used to change the buffer's label in the bufferline.
	--- Please note some names can/will break the
	--- bufferline so use this at your discretion knowing that it has
	--- some limitations that will *NOT* be fixed.
	-- name_formatter = function(buf)  -- buf contains:
	--       -- name                | str        | the basename of the active file
	--       -- path                | str        | the full path of the active file
	--       -- bufnr (buffer only) | int        | the number of the active buffer
	--       -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
	--       -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
	-- end,
	max_name_length = vim.o.columns * 2 / 3,
	max_prefix_length = vim.o.columns * 2 / 3, -- prefix used when a buffer is de-duplicated
	truncate_names = true, -- whether or not tab names should be truncated
	tab_size = 18,
	diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
	diagnostics_update_in_insert = false,
	-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
	-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
	-- return "(" .. count .. ")"
	-- end,
	-- NOTE: this will be called a lot so don't do any heavy processing here
	custom_filter = function(buf_number, buf_numbers)
		-- filter out by buffer name
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
	color_icons = true, -- true | false, whether or not to add the filetype icon highlights
	show_buffer_icons = true, -- true | false, disable filetype icons for buffers
	show_buffer_close_icons = true, --true | false,
	show_buffer_default_icon = true, --true | false, -- whether or not an unrecognised filetype should show a default icon
	show_close_icon = true, -- true | false,
	show_tab_indicators = true, -- true | false,
	show_duplicate_prefix = true, -- true | false  whether to show duplicate buffer prefix
	persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
	-- can also be a table containing 2 custom separators
	-- [focused and unfocused]. eg: { '|', '|' }
	separator_style = "thick", --"slant" | "thick" | "thin" | "padded_slant" { 'any', 'any' },
	enforce_regular_tabs = true, -- false | true,
	always_show_bufferline = false, -- true | false,
	-- hover = {
	--   enabled = true,
	--   delay = 200,
	--   reveal = { "close" },
	-- },
	-- sort_by = "directory", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
	-- add custom logic
	-- return buffer_a.modified > buffer_b.modified
	-- end
}

bufferline.setup({
	options = options,
	highlights = base46.bufferlineTheme(),
})
