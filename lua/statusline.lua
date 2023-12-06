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

function highlights:load()
	-- bg
	self.bg_dark = get_highlight("TabLine").bg
	self.bg = get_highlight("TabLineFill").bg
	self.bg_alt = get_highlight("TabLineSel").bg

	-- active/inactive
	self.fg = get_highlight("Normal").fg
	self.active = get_highlight("PmenuSel").fg
	self.gray = get_highlight("NonText").fg

	-- misc
	self.blue = get_highlight("Function").fg
	self.orange = get_highlight("Constant").fg
	self.green = get_highlight("DiagnosticOk").fg
	self.yellow = get_highlight("DiagnosticWarn").fg
	self.red = get_highlight("DiagnosticError").fg
	self.purple = get_highlight("DiagnosticHint").fg
	self.cyan = get_highlight("DiagnosticInfo").fg
end

local function set_default_hl(name, t)
	t.default = true
	vim.api.nvim_set_hl(0, name, t)
end

function highlights:apply()
	set_default_hl("StatusLineBackground", { bg = highlights.bg, fg = highlights.gray })

	set_default_hl("StatusLineSep", { fg = highlights.bg_alt, bg = highlights.bg })
	set_default_hl("StatusLineNormal", { bg = highlights.bg_alt, fg = highlights.fg, bold = true })
	set_default_hl("StatusLineInsert", { bg = highlights.bg_alt, fg = highlights.blue, bold = true })
	set_default_hl("StatusLineVisual", { bg = highlights.bg_alt, fg = highlights.purple, bold = true })
	set_default_hl("StatusLineCommand", { bg = highlights.bg_alt, fg = highlights.green, bold = true })
	set_default_hl("StatusLineReplace", { bg = highlights.bg_alt, fg = highlights.orange, bold = true })
	set_default_hl("StatusLineOther", { bg = highlights.bg_alt, fg = highlights.yellow, bold = true })

	set_default_hl("StatusLineLspSymbol", { bg = highlights.bg_alt, fg = highlights.active, bold = true })
	set_default_hl("StatusLineLspName", { bg = highlights.bg_alt, fg = highlights.fg, bold = true })

	set_default_hl("StatusLineDiagError", { bg = highlights.bg, fg = highlights.red })
	set_default_hl("StatusLineDiagHint", { bg = highlights.bg, fg = highlights.purple })
	set_default_hl("StatusLineDiagInfo", { bg = highlights.bg, fg = highlights.cyan })
	set_default_hl("StatusLineDiagWarn", { bg = highlights.bg, fg = highlights.yellow })
	set_default_hl("StatusLineDiagOk", { bg = highlights.bg, fg = highlights.green })
	set_default_hl("StatusLineGitBranch", { bg = highlights.bg, fg = highlights.fg })
	set_default_hl("StatusLineHarpoonActive", { bg = highlights.bg, fg = highlights.active, bold = true })
end

highlights:load()
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
		string.format("%%#StatusLineSep#%s", icons.separators.left_rounded),
		string.format("%%#%s#%s", hl, mode),
		string.format("%%#StatusLineSep#%s", icons.separators.right_rounded),
	})
end

components.filepath = function()
	local width = vim.api.nvim_win_get_width(0)

	if vim.bo.buftype == "terminal" then
		return "%#StatusLineBackground#%t"
	elseif width > 110 then
		return "%#StatusLineBackground#%t"
	else
		local buf_fname = vim.fn.expand("%:t")
		return string.format("%%#StatusLineBackground#%s", buf_fname)
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
		for _, server in pairs(vim.lsp.get_clients({ bufnr = current_buffer })) do
			table.insert(names, server.name)
		end
		local names = table.concat(names, " ")
		return table.concat({
			string.format("%%#StatusLineSep#%s", icons.separators.left_rounded),
			string.format("%%#StatusLineLspSymbol# ["),
			string.format("%%#StatusLineLspName#%s", names),
			string.format("%%#StatusLineLspSymbol#]"),
			string.format("%%#StatusLineSep#%s", icons.separators.right_rounded),
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
		string.format("%%#StatusLineGitBranch#%s%s", icons.misc.branch, git_status.head),
		string.format("%%#StatusLineDiagOk# %s", added),
		string.format("%%#StatusLineDiagWarn# %s", changed),
		string.format("%%#StatusLineDiagError# %s", removed),
	})
end

components.file_icon = function()
	local has_devicons, devicons = pcall(require, "nvim-web-devicons")
	if not has_devicons then
		return ""
	end
	local file_name, file_ext = vim.fn.expand("%:t"), vim.fn.expand("%:e")
	local ft_icon, ft_color = devicons.get_icon_color(file_name)
	if not ft_icon then
		return ""
	end
	set_default_hl("StatusLine" .. file_ext, { fg = ft_color, bg = highlights.bg })
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

components.harpoon = function()
	local ok, harpoon = pcall(require, "harpoon")
	if not ok then
		return ""
	end
	local width = vim.api.nvim_win_get_width(0)
	if width < 110 then
		return ""
	end

	local items = harpoon:list().items
	local paths = {}
	for i, item in ipairs(items) do
		local fname = item.value
		local fname_short = vim.fn.fnamemodify(fname, ":t")
		local component = string.format("%%#StatusLineBackground#%s", fname_short)
		if fname == vim.fn.expand("%:p:.") then
			component = string.format("%%#StatusLineHarpoonActive#%s", fname_short)
		end
		table.insert(paths, component)
	end
	local list = table.concat(paths, " ")
	return string.format("󱡀 [%s]", list)
end

local statusline = {}

function statusline.active()
	local function concat_components(comps)
		return vim.iter(comps):skip(1):fold(comps[1], function(acc, component)
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
			components.harpoon(),
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
	highlights:load()
	highlights:apply()
end
au("colorscheme", "*", reload, "reload statusline")

vim.o.showmode = false
vim.g.qf_disable_statusline = 1
vim.o.laststatus = 2

return statusline
