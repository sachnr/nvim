local ok, cmp = pcall(require, "cmp")
if not ok then
	return
end

cmp.setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })

local db_url = vim.fn.expand("$DATABASE_URL")
if db_url then
	vim.g.db = db_url
end
