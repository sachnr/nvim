---@diagnostic disable: undefined-field
local function run_formatter(text, exe, args)
	local split = vim.split(text, "\n")
	local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

	local job = require("plenary.job"):new({
		command = exe,
		args = args,
		writer = { result },
	})
	return job:sync()
end

local function format_embedded_stuff(exe, args, query, query_lang, treesitter_capture_name)
	local bufnr = vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(bufnr, query_lang, {})
	local tree = parser:parse()[1]
	local root = tree:root()
	local embedded_lang = vim.treesitter.query.parse(query_lang, query)

	local changes = {}

	for id, node in embedded_lang:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_lang.captures[id]
		if name == treesitter_capture_name then
			local range = { node:range() }
			local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr), exe, args)

			-- indentation
			local indentation = string.rep(" ", range[2])
			for idx, line in ipairs(formatted) do
				formatted[idx] = indentation .. line
			end

			table.insert(changes, 1, {
				start = range[1] + 1,
				final = range[3],
				formatted = formatted,
			})
		end
	end

	for _, change in ipairs(changes) do
		vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
	end
end

---@class Query
---@field exe string
---@field args table
---@field ts_query string
---@field ts_query_lang string
---@field ts_cap_name string
local Query = {}

--- Constructor for Query
---@param object table
---@return Query
function Query:builder(object)
	object = object or {
		exe = "",
		args = {},
		ts_query = "",
		ts_query_lang = "",
		ts_cap_name = "",
	}
	setmetatable(object, self)
	self.__index = self
	return object
end

--- Run method for Query
function Query:run()
	format_embedded_stuff(self.exe, self.args, self.ts_query, self.ts_query_lang, self.ts_cap_name)
end

return Query
