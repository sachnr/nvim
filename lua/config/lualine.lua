local line_ok, lualine = pcall(require, "lualine")
if not line_ok then
	return
end

local ok, base46 = pcall(require, "base46")
if not ok then
	return
end

local colors = base46.get_theme_tb("base_30")

local theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.one_bg3, fg = colors.white },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
	insert = {
		a = { bg = colors.dark_purple, fg = colors.black, gui = "bold" },
		b = { bg = colors.one_bg3, fg = colors.white },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
	visual = {
		a = { bg = colors.cyan, fg = colors.black, gui = "bold" },
		b = { bg = colors.one_bg3, fg = colors.white },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
	replace = {
		a = { bg = colors.orange, fg = colors.black, gui = "bold" },
		b = { bg = colors.one_bg3, fg = colors.white },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
	command = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.one_bg3, fg = colors.white },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
	inactive = {
		a = { bg = colors.one_bg3, fg = colors.light_grey, gui = "bold" },
		b = { bg = colors.one_bg, fg = colors.light_grey },
		c = { bg = colors.one_bg, fg = colors.light_grey },
	},
}

local function getLspName()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return "  " .. client.name
		end
	end
	return "  " .. msg
end

local disabled_filetypes = {
	"^NvimTree$",
	"^packer$",
	"^startify$",
	"^fugitive$",
	"^fugitive$",
	"^fugitiveblame$",
	"^qf$",
	"^help$",
}

local options = {
	icons_enabled = true,
	theme = theme,
	component_separators = { left = "", right = "" },
	section_separators = { left = "", right = "" },
	disabled_filetypes = {
		statusline = disabled_filetypes,
		winbar = disabled_filetypes,
	},
	ignore_focus = {},
	always_divide_middle = true,
	globalstatus = false,
	refresh = {
		statusline = 1000,
		tabline = 1000,
		winbar = 1000,
	},
}

local sections = {
	lualine_a = {
		{
			function()
				return ""
			end,
		},
		{
			"mode",
		},
	},
	lualine_b = { "filename" },
	lualine_c = { "branch", "diff" },
	lualine_x = { "location" },
	lualine_y = { "searchcount", "diagnostics", "filetype", "progress" },
	lualine_z = { { getLspName } },
}
local inactive_sections = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = { "location" },
	lualine_y = {},
	lualine_z = {},
}
local tabline = {}
local winbar = {}
local inactive_winbar = {}
local extensions = { "toggleterm", "nvim-tree", "nvim-dap-ui" }

lualine.setup({
	options = options,
	sections = sections,
	inactive_sections = inactive_sections,
	tabline = tabline,
	winbar = winbar,
	inactive_winbar = inactive_winbar,
	extensions = extensions,
})
