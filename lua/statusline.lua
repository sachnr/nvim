local icons = require("icons")

local modes = {
	["n"] = "NORMAL",
	["no"] = "OP-PENDING",
	["nov"] = "OP-PENDING",
	["noV"] = "OP-PENDING",
	["no\22"] = "OP-PENDING",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["nt"] = "NORMAL",
	["ntT"] = "NORMAL",
	["v"] = "VISUAL",
	["vs"] = "VISUAL",
	["V"] = "VISUAL",
	["Vs"] = "VISUAL",
	["\22"] = "VISUAL",
	["\22s"] = "VISUAL",
	["s"] = "SELECT",
	["S"] = "SELECT",
	["\19"] = "SELECT",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rx"] = "REPLACE",
	["Rv"] = "VIRT REPLACE",
	["Rvc"] = "VIRT REPLACE",
	["Rvx"] = "VIRT REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function get_highlight(name)
	return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local highlights = {}

function highlights:get_highlights()
	self.bg_dark = get_highlight("TabLine").bg
	self.bg = get_highlight("TabLineFill").bg
	self.bg_alt = get_highlight("TabLineSel").bg

	self.white = get_highlight("Normal").fg
	self.red = get_highlight("DiagnosticError").fg
	self.green = get_highlight("DiagnosticOk").fg
	self.yellow = get_highlight("DiagnosticWarn").fg
	self.blue = get_highlight("Function").fg
	self.gray = get_highlight("NonText").fg
	self.orange = get_highlight("Constant").fg
	self.purple = get_highlight("Statement").fg
	self.cyan = get_highlight("Special").fg

	self.diag_warn = get_highlight("DiagnosticWarn").fg
	self.diag_error = get_highlight("DiagnosticError").fg
	self.diag_hint = get_highlight("DiagnosticHint").fg
	self.diag_info = get_highlight("DiagnosticInfo").fg

	self.git_del = get_highlight("GitSignsDelete").fg
	self.git_add = get_highlight("GitSignsAdd").fg
	self.git_change = get_highlight("GitSignsChange").fg
end

function highlights:set_default_hl(name, data)
	data.default = true
	vim.api.nvim_set_hl(0, name, data)
end

function highlights:apply()
	self:set_default_hl("StatusLineBackground", { bg = self.bg, fg = self.gray })

	self:set_default_hl("StatusLineSeparator", { fg = self.bg_alt, bg = self.bg })
	self:set_default_hl("StatusLineNormal", { bg = self.bg_alt, fg = self.white, bold = true })
	self:set_default_hl("StatusLineInsert", { bg = self.bg_alt, fg = self.blue, bold = true })
	self:set_default_hl("StatusLineVisual", { bg = self.bg_alt, fg = self.purple, bold = true })
	self:set_default_hl("StatusLineCommand", { bg = self.bg_alt, fg = self.green, bold = true })
	self:set_default_hl("StatusLineReplace", { bg = self.bg_alt, fg = self.orange, bold = true })
	self:set_default_hl("StatusLineOther", { bg = self.bg_alt, fg = self.yellow, bold = true })

	self:set_default_hl("StatusLineLspSymbol", { bg = self.bg_alt, fg = self.blue, bold = true })
	self:set_default_hl("StatusLineLspName", { bg = self.bg_alt, fg = self.white, bold = true })

	self:set_default_hl("StatusLineDiagError", { bg = self.bg, fg = self.diag_error })
	self:set_default_hl("StatusLineDiagHint", { bg = self.bg, fg = self.diag_hint })
	self:set_default_hl("StatusLineDiagInfo", { bg = self.bg, fg = self.diag_info })
	self:set_default_hl("StatusLineDiagWarn", { bg = self.bg, fg = self.diag_warn })

	self:set_default_hl("StatusLineBranch", { fg = self.white, bg = self.bg })
	self:set_default_hl("StatusLineGitDel", { fg = self.git_del, bg = self.bg })
	self:set_default_hl("StatusLineGitAdd", { fg = self.git_add, bg = self.bg })
	self:set_default_hl("StatusLineGitChange", { fg = self.git_change, bg = self.bg })
end

highlights:get_highlights()
highlights:apply()

local components = {}

components.mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode = string.format(" %s ", modes[current_mode]):upper()

	local hl = "StatusLineOther"
	if current_mode == "n" then
		hl = "StatusLineNormal"
	elseif current_mode == "i" or current_mode == "ic" then
		hl = "StatusLineInsert"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		hl = "StatusLineVisual"
	elseif current_mode == "R" then
		hl = "StatusLineReplace"
	elseif current_mode == "c" then
		hl = "StatusLineCommand"
	end

	return table.concat({
		string.format("%%#StatusLineSeparator#%s", icons.separators.left_rounded),
		string.format("%%#%s#%s", hl, mode),
		string.format("%%#StatusLineSeparator#%s", icons.separators.right_rounded),
	})
end

components.filepath = function()
	local width = vim.api.nvim_win_get_width(0)

	if vim.bo.buftype == "terminal" then
		return "%#StatusLineBackground#%t"
	elseif width > 110 then
		return "%#StatusLineBackground#%F%m%r"
	else
		local buf_name = vim.api.nvim_buf_get_name(0)
		local name = vim.fn.fnamemodify(buf_name, ":t")
		return string.format("%%#StatusLineBackground#%s", name)
	end
end

components.lsp_progress = function()
	local current_buffer = vim.api.nvim_get_current_buf()
	local is_not_attached = next(vim.lsp.get_clients({ bufnr = current_buffer })) == nil
	local is_not_normal_buffer = vim.bo.buftype ~= ""

	if is_not_attached or is_not_normal_buffer then
		return ""
	else
		local names = {}
		for i, server in pairs(vim.lsp.get_clients({ bufnr = current_buffer })) do
			table.insert(names, server.name)
		end
		local names = table.concat(names, " ")
		return table.concat({
			string.format("%%#StatusLineSeparator#%s", icons.separators.left_rounded),
			string.format("%%#StatusLineLspSymbol# ["),
			string.format("%%#StatusLineLspName#%s", names),
			string.format("%%#StatusLineLspSymbol#]"),
			string.format("%%#StatusLineSeparator#%s", icons.separators.right_rounded),
		})
	end
end

components.git = function()
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict
	local added = (git_status.added and git_status.added ~= 0) and (string.format("+%s", git_status.added)) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and (string.format("~%s", git_status.changed))
		or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and (string.format("-%s", git_status.removed))
		or ""

	return table.concat({
		string.format("%%#StatusLineBranch#%s%s", icons.misc.branch, git_status.head),
		string.format("%%#StatusLineGitAdd# %s", added),
		string.format("%%#StatusLineGitChange# %s", changed),
		string.format("%%#StatusLineGitDel# %s", removed),
	})
end

components.file_icon = function()
	local has_devicons, devicons = pcall(require, "nvim-web-devicons")
	if not has_devicons then
		return ""
	end
	local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
	local ft_icon, ft_color = devicons.get_icon_color(file_name)
	highlights:set_default_hl("StatusLine" .. file_ext, { fg = ft_color, bg = highlights.bg })
	return string.format("%%#StatusLine%s#%s", file_ext, ft_icon)
end

components.indent_info = function()
	if vim.bo.expandtab then
		return string.format("%%#StatusLineBackground#Spaces[%s]", vim.bo.shiftwidth)
	else
		return string.format("%%#StatusLineBackground#Tabs[%s]", vim.bo.tabstop)
	end
end

components.diagnostics = function()
	local current_buffer = vim.api.nvim_get_current_buf()
	local is_not_attached = next(vim.lsp.get_clients({ bufnr = current_buffer })) == nil
	local is_not_normal_buffer = vim.bo.buftype ~= ""

	if is_not_attached or is_not_normal_buffer then
		return ""
	end

	local errors = #vim.diagnostic.get(current_buffer, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(current_buffer, { severity = vim.diagnostic.severity.WARN })
	local hints = #vim.diagnostic.get(current_buffer, { severity = vim.diagnostic.severity.HINT })
	local info = #vim.diagnostic.get(current_buffer, { severity = vim.diagnostic.severity.INFO })

	return table.concat({
		(errors and errors > 0) and string.format("%%#StatusLineDiagError#%s%s ", icons.diagnostics.error, errors)
			or "",
		(warnings and warnings > 0) and string.format("%%#StatusLineDiagWarn#%s%s ", icons.diagnostics.warn, warnings)
			or "",
		(hints and hints > 0) and string.format("%%#StatusLineDiagHint#%s%s ", icons.diagnostics.hint, hints) or "",
		(info and info > 0) and string.format("%%#StatusLineDiagInfo#%s%s ", icons.diagnostics.info, info) or "",
	})
end

local statusline = {}

function statusline.active()
	local function concat_components(components)
		return vim.iter(components):skip(1):fold(components[1], function(acc, component)
			return #component > 0 and string.format("%s  %s", acc, component) or acc
		end)
	end

	return table.concat({
		concat_components({
			components.mode(),
			components.git(),
			components.file_icon(),
			components.filepath(),
		}),
		"%#StatusLineBackground#%=",
		concat_components({
			components.diagnostics(),
			components.indent_info(),
			components.lsp_progress(),
		}),
		" ",
	})
end

function statusline.inactive()
	return table.concat({
		components.filepath(),
	})
end

local augroup = vim.api.nvim_create_augroup("statusline", {})

local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
end

local set_active = function()
	vim.wo.statusline = "%!v:lua.require'statusline'.active()"
end
au({ "WinEnter", "BufEnter" }, "*", set_active, "Set active statusline")

local set_inactive = function()
	vim.wo.statusline = "%!v:lua.require'statusline'.inactive()"
end
au({ "WinLeave", "BufLeave" }, "*", set_inactive, "Set inactive statusline")

local reload = function()
	highlights:get_highlights()
	highlights:apply()
end
au("colorscheme", "*", reload, "reload statusline")

vim.o.showmode = false
vim.g.qf_disable_statusline = 1
vim.o.laststatus = 2

return statusline
