local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local ok, base46 = pcall(require, "base46")
if not ok then
	return
end

local colors = base46.get_theme_tb("base_30")

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
	max_name_length = 18,
	max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
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
			text = "File Explorer",
			text_align = "center", -- "left" | "center" | "right"
			highlight = "BufferlineFill",
			separator = true,
			-- padding = 1,
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
	separator_style = "slant", --"slant" | "thick" | "thin" | "padded_slant" { 'any', 'any' },
	enforce_regular_tabs = false, -- false | true,
	always_show_bufferline = false, -- true | false,
	hover = {
	  enabled = true,
	  delay = 200,
	  reveal = { "close" },
	},
	-- sort_by = "directory", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
	-- add custom logic
	-- return buffer_a.modified > buffer_b.modified
	-- end
}

local function hex_to_rgb(color)
	local hex = color:gsub("#", "")
	return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5), 16)
end

local function alter(attr, percent)
	return math.floor(attr * (100 + percent) / 100)
end

local function shade(color, percent)
	if not color then
		return "NONE"
	end
	local r, g, b = hex_to_rgb(color)
	if not r or not g or not b then
		return "NONE"
	end
	r, g, b = alter(r, percent), alter(g, percent), alter(b, percent)
	r, g, b = math.min(r, 255), math.min(g, 255), math.min(b, 255)
	return string.format("#%02x%02x%02x", r, g, b)
end

-- bg
local separator_background_color = colors.statusline_bg
local visible_bg = colors.one_bg
local normal_bg = colors.one_bg3
local underline_sp = colors.red
local has_underline_indicator = true

-- fg
local normal_fg = colors.white
local comment_fg = colors.light_grey
local hint_fg = colors.purple
local info_fg = colors.cyan
local warning_fg = colors.yellow
local error_fg = colors.red
local string_fg = comment_fg
local duplicate_color = colors.green
local win_separator_fg = colors.darker_black
local tabline_sel_bg = normal_fg

-- fg shade
local diagnostic_shading = -34
local normal_diagnostic_fg = shade(normal_fg, diagnostic_shading)
local comment_diagnostic_fg = shade(comment_fg, diagnostic_shading)
local hint_diagnostic_fg = shade(hint_fg, diagnostic_shading)
local info_diagnostic_fg = shade(info_fg, diagnostic_shading)
local warning_diagnostic_fg = shade(warning_fg, diagnostic_shading)
local error_diagnostic_fg = shade(error_fg, diagnostic_shading)

local highlights = {
	fill = {
		fg = comment_fg,
		bg = separator_background_color,
	},
	group_separator = {
		fg = comment_fg,
		bg = separator_background_color,
	},
	group_label = {
		bg = comment_fg,
		fg = separator_background_color,
	},
	tab = {
		fg = comment_fg,
		bg = visible_bg,
	},
	tab_selected = {
		fg = tabline_sel_bg,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	tab_close = {
		fg = comment_fg,
		bg = visible_bg,
	},
	close_button = {
		fg = comment_fg,
		bg = visible_bg,
	},
	close_button_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	close_button_selected = {
		fg = error_fg,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	background = {
		fg = comment_fg,
		bg = visible_bg,
	},
	buffer = {
		fg = comment_fg,
		bg = visible_bg,
	},
	buffer_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	buffer_selected = {
		fg = normal_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	numbers = {
		fg = comment_fg,
		bg = visible_bg,
	},
	numbers_selected = {
		fg = normal_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	numbers_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	diagnostic = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	diagnostic_visible = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	diagnostic_selected = {
		fg = normal_diagnostic_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	hint = {
		fg = comment_fg,
		sp = hint_fg,
		bg = visible_bg,
	},
	hint_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	hint_selected = {
		fg = hint_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	hint_diagnostic = {
		fg = comment_diagnostic_fg,
		sp = hint_diagnostic_fg,
		bg = visible_bg,
	},
	hint_diagnostic_visible = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	hint_diagnostic_selected = {
		fg = hint_diagnostic_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	info = {
		fg = comment_fg,
		sp = info_fg,
		bg = visible_bg,
	},
	info_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	info_selected = {
		fg = info_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	info_diagnostic = {
		fg = comment_diagnostic_fg,
		sp = info_diagnostic_fg,
		bg = visible_bg,
	},
	info_diagnostic_visible = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	info_diagnostic_selected = {
		fg = info_diagnostic_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	warning = {
		fg = comment_fg,
		sp = warning_fg,
		bg = visible_bg,
	},
	warning_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	warning_selected = {
		fg = warning_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	warning_diagnostic = {
		fg = comment_diagnostic_fg,
		sp = warning_diagnostic_fg,
		bg = visible_bg,
	},
	warning_diagnostic_visible = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	warning_diagnostic_selected = {
		fg = warning_diagnostic_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	error = {
		fg = comment_fg,
		bg = visible_bg,
		sp = error_fg,
	},
	error_visible = {
		fg = comment_fg,
		bg = visible_bg,
	},
	error_selected = {
		fg = error_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	error_diagnostic = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
		sp = error_diagnostic_fg,
	},
	error_diagnostic_visible = {
		fg = comment_diagnostic_fg,
		bg = visible_bg,
	},
	error_diagnostic_selected = {
		fg = error_diagnostic_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		underline = has_underline_indicator,
		sp = underline_sp,
	},
	modified = {
		fg = string_fg,
		bg = visible_bg,
	},
	modified_visible = {
		fg = string_fg,
		bg = visible_bg,
	},
	modified_selected = {
		fg = error_fg,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	duplicate_selected = {
		fg = duplicate_color,
		italic = true,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	duplicate_visible = {
		fg = duplicate_color,
		italic = true,
		bg = visible_bg,
	},
	duplicate = {
		fg = duplicate_color,
		italic = true,
		bg = visible_bg,
	},
	separator_selected = {
		fg = separator_background_color,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	separator_visible = {
		fg = separator_background_color,
		bg = visible_bg,
	},
	separator = {
		fg = separator_background_color,
		bg = visible_bg,
	},
	tab_separator = {
		fg = separator_background_color,
		bg = visible_bg,
	},
	tab_separator_selected = {
		fg = separator_background_color,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	indicator_selected = {
		fg = tabline_sel_bg,
		bg = normal_bg,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	indicator_visible = {
		fg = visible_bg,
		bg = visible_bg,
	},
	pick_selected = {
		fg = error_fg,
		bg = normal_bg,
		bold = true,
		italic = true,
		sp = underline_sp,
		underline = has_underline_indicator,
	},
	pick_visible = {
		fg = error_fg,
		bg = visible_bg,
		bold = true,
		italic = true,
	},
	pick = {
		fg = error_fg,
		bg = visible_bg,
		bold = true,
		italic = true,
	},
	offset_separator = {
		fg = win_separator_fg,
		bg = separator_background_color,
	},
}

bufferline.setup({
	options = options,
	highlights = highlights,
})
