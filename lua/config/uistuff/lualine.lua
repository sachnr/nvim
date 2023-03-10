local line_ok, lualine = pcall(require, "lualine")
if not line_ok then
	return
end

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

local options = {
	icons_enabled = true,
	theme = "base46",
	component_separators = { left = "|", right = "|" },
	section_separators = { left = "", right = "" },
	disabled_filetypes = {
		statusline = {
			"packer",
			"qf",
			"help",
			"quickfix",
			"prompt",
			"alpha",
			"dap-repl",
			"Trouble",
			"lspsagaoutline",
		},
		winbar = {
			"quickfix",
			"prompt",
			"NvimTree",
			"packer",
			"qf",
			"help",
			"alpha",
			"dap-repl",
			"Trouble",
			"lspsagaoutline",
		},
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
	lualine_x = {
		"location",
		{
			require("lazy.status").updates,
			cond = require("lazy.status").has_updates,
			color = { fg = "#ff9e64" },
		},
	},
	lualine_y = { "searchcount", "diagnostics", "filetype", "progress" },
	lualine_z = { { getLspName } },
}
local inactive_sections = {
	lualine_a = { {
		function()
			return vim.api.nvim_win_get_number(0)
		end,
	} },
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = { "location" },
	lualine_y = {},
	lualine_z = {},
}
local tabline = {}
local winbar = { lualine_c = {
	"filename",
} }
local inactive_winbar = { lualine_c = {
	"filename",
} }
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
