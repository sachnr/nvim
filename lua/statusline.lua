local icons = require("icons")

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
	self.active = get_highlight("PmenuSel").bg
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
	set_default_hl("StatusLineNormal", { bg = highlights.bg, fg = highlights.fg })

	set_default_hl("StatusLineActive", { bg = highlights.bg, fg = highlights.active, bold = true })
	set_default_hl("StatusLineLspName", { bg = highlights.bg, fg = highlights.fg, bold = true })

	set_default_hl("StatusLineDiagError", { bg = highlights.bg, fg = highlights.red })
	set_default_hl("StatusLineDiagHint", { bg = highlights.bg, fg = highlights.purple })
	set_default_hl("StatusLineDiagInfo", { bg = highlights.bg, fg = highlights.cyan })
	set_default_hl("StatusLineDiagWarn", { bg = highlights.bg, fg = highlights.yellow })
	set_default_hl("StatusLineDiagOk", { bg = highlights.bg, fg = highlights.green })
end

highlights:load()
highlights:apply()

local components = {}

components.filepath = function(bufnr)
	local width = vim.api.nvim_win_get_width(0)

	if vim.bo[bufnr].buftype == "terminal" then
		return "%#StatusLineNormal#%t"
	elseif width > 110 then
		return "%#StatusLineNormal#%t"
	else
		local buf_fname = vim.fn.bufname(bufnr)
		return string.format("%%#StatusLineBackground#%s", buf_fname)
	end
end

components.lines = function()
	local width = vim.api.nvim_win_get_width(0)
	if width < 110 then
		return ""
	else
		return string.format("%%#StatusLineBackground#Loc[%s]", vim.fn.line("$"))
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
			string.format("%%#StatusLineActive# ["),
			string.format("%%#StatusLineLspName#%s", names),
			string.format("%%#StatusLineActive#]"),
		})
	end
end

components.git = function()
	local head = vim.b.gitsigns_head
	if not head then
		return ""
	end

	local width = vim.api.nvim_win_get_width(0)
	if width < 110 then
		return ""
	end

	local git_status = vim.b.gitsigns_status_dict
	local added = (git_status.added and git_status.added ~= 0) and (string.format("+%s", git_status.added)) or ""
	local changed = (git_status.changed and git_status.changed ~= 0) and (string.format("~%s", git_status.changed))
		or ""
	local removed = (git_status.removed and git_status.removed ~= 0) and (string.format("-%s", git_status.removed))
		or ""

	return table.concat({
		string.format("%%#StatusLineBackground#%s%s", icons.misc.branch, git_status.head),
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

	vim.api.nvim_set_hl(0, string.format("StatusLine%s", file_ext), { bg = highlights.bg, fg = ft_color })
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
	local harpoon = require("harpoon")
	local width = vim.api.nvim_win_get_width(0)
	if width < 110 then
		return ""
	end

	local items = harpoon:list().items
	local paths = {}
	for i, item in ipairs(items) do
		local fname = item.value
		local fname_short = vim.fn.fnamemodify(fname, ":t")
		local component = string.format("%%#StatusLineBackground#%s: %s", i, fname_short)
		if fname == vim.fn.expand("%:p:.") then
			component = table.concat({
				string.format("%%#StatusLineDiagInfo#%s: ", i),
				string.format("%%#StatusLineActive#%s", fname_short),
			})
		end
		table.insert(paths, component)
	end
	local list = table.concat(paths, "  ")
	return string.format("󰐃 [%s]", list)
end

local statusline = {}

function statusline.active()
	local bufnr = vim.api.nvim_get_current_buf()

	local function concat_components(comps)
		return vim.iter(comps):skip(1):fold(comps[1], function(acc, component)
			return #component > 0 and string.format("%s  %s", acc, component) or acc
		end)
	end

	return table.concat({
		concat_components({
			-- components.mode(),
			-- components.file_icon(),
			components.filepath(bufnr),
			components.lines(),
			components.git(),
			components.diagnostics(),
		}),
		"%#StatusLineBackground#%=",
		concat_components({
			components.harpoon(),
			-- components.indent_info(),
			components.lsp_progress(),
		}),
		" ",
	})
end

function statusline.inactive()
	local bufnr = vim.api.nvim_get_current_buf()
	return table.concat({
		components.filepath(bufnr),
	})
end

local augroup = vim.api.nvim_create_augroup("statusline", {})

local au = function(event, pattern, callback, desc)
	vim.api.nvim_create_autocmd(event, { group = augroup, pattern = pattern, callback = callback, desc = desc })
end

local set_active = function()
	local filetype = vim.bo.filetype
	local found = string.find(filetype, "dapui")
	if found or filetype == "dap-repl" then
		vim.wo.statusline = ""
	else
		vim.wo.statusline = "%!v:lua.require'statusline'.active()"
	end
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
