local present, cokeline = pcall(require, "cokeline")

if not present then
	return
end

local get_hex = require("cokeline/utils").get_hex
local mappings = require("cokeline/mappings")

local str_rep = string.rep

local green = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3
local blue = vim.g.terminal_color_4

local comments_fg = get_hex("Comment", "fg")
local errors_fg = get_hex("DiagnosticError", "fg")
local warnings_fg = get_hex("DiagnosticWarn", "fg")

local min_buffer_width = 20

local components = {
	separator = {
		text = " ",
		bg = get_hex("Normal", "bg"),
		truncation = { priority = 1 },
	},

	space = {
		text = " ",
		truncation = { priority = 1 },
	},

	left_half_circle = {
		text = "",
		fg = function(buffer)
			return buffer.is_focused and blue or get_hex("colorcolumn", "bg")
		end,
		bg = get_hex("Normal", "bg"),
		truncation = { priority = 1 },
	},

	right_half_circle = {
		text = "",
		fg = function(buffer)
			return buffer.is_focused and blue or get_hex("colorcolumn", "bg")
		end,
		bg = get_hex("Normal", "bg"),
		truncation = { priority = 1 },
	},

	devicon = {
		text = function(buffer)
			return buffer.devicon.icon
		end,
		fg = function(buffer)
			return buffer.is_focused and get_hex("colorcolumn", "bg") or get_hex("Comment", "fg")
		end,
		truncation = { priority = 1 },
	},

	index = {
		text = function(buffer)
			return buffer.index .. ": "
		end,
		fg = function(buffer)
			return (buffer.diagnostics.errors ~= 0 and errors_fg)
				or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
				or nil
		end,
		truncation = { priority = 1 },
	},

	unique_prefix = {
		text = function(buffer)
			return buffer.unique_prefix
		end,
		fg = comments_fg,
		style = "italic",
		truncation = {
			priority = 3,
			direction = "left",
		},
	},

	filename = {
		text = function(buffer)
			return buffer.filename
		end,
		fg = function(buffer)
			return buffer.is_focused and get_hex("colorcolumn", "bg") or get_hex("Comment", "fg")
		end,
		style = function(buffer)
			return (buffer.is_focused and "bold")
		end,
		truncation = {
			priority = 2,
			direction = "right",
		},
	},

	close_or_unsaved = {
		text = function(buffer)
			return buffer.is_modified and "●" or ""
		end,
		fg = get_hex("colorcolumn", "bg"),
		delete_buffer_on_left_click = true,
		truncation = { priority = 1 },
	},
}

local get_remaining_space = function(buffer)
	local used_space = 0
	for _, component in pairs(components) do
		used_space = used_space
			+ vim.fn.strwidth(
				(type(component.text) == "string" and component.text)
					or (type(component.text) == "function" and component.text(buffer))
			)
	end
	return math.max(0, min_buffer_width - used_space)
end

local left_padding = {
	text = function(buffer)
		local remaining_space = get_remaining_space(buffer)
		return str_rep(" ", remaining_space / 2 + remaining_space % 2)
	end,
}

local right_padding = {
	text = function(buffer)
		local remaining_space = get_remaining_space(buffer)
		return str_rep(" ", remaining_space / 2)
	end,
}

require("cokeline").setup({
	show_if_buffers_are_at_least = 1,

	buffers = {
		-- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
		-- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
		focus_on_delete = "next",
		new_buffers_position = "next",
	},

	rendering = {
		max_buffer_width = 24,
	},

	default_hl = {
		fg = function(buffer)
			return buffer.is_focused and get_hex("colorcolumn", "bg") or get_hex("Comment", "fg")
		end,
		bg = function(buffer)
			return buffer.is_focused and blue or get_hex("colorcolumn", "bg")
		end,
	},

	sidebar = {
		filetype = "NvimTree",
		components = {
			{
				text = "",
				fg = blue,
				bg = get_hex("NvimTreeNormal", "bg"),
				style = "bold",
			},
		},
	},

	components = {
		components.separator,
		components.left_half_circle,
		left_padding,
		components.devicon,
		components.index,
		components.unique_prefix,
		components.filename,
		components.space,
		right_padding,
		components.close_or_unsaved,
		components.right_half_circle,
	},
})
