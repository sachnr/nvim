local function is_valid_buffer(buf_id)
	return vim.api.nvim_buf_is_valid(buf_id) and vim.fn.getbufvar(buf_id, "&buflisted") == 1
end

local function is_file_buffer(buf_id)
	return is_valid_buffer(buf_id) and vim.fn.getbufvar(buf_id, "&buftype") ~= "terminal"
end

local function get_active_buffers()
	local bufs = vim.api.nvim_list_bufs()
	local active_buffers = {}
	local count = 0
	for _, buf_id in pairs(bufs) do
		if is_file_buffer(buf_id) then
			count = count + 1
			active_buffers[count] = buf_id
		end
	end
	return active_buffers
end

local function open_buf_id(buf_id)
	-- TODO: find a better way to do this
	vim.api.nvim_command(string.format("buffer %d", buf_id))
end

local function find_buffer(buf_id, buffer_table)
	for idx, table_buf_id in ipairs(buffer_table) do
		if buf_id == table_buf_id then
			return idx
		end
	end
end

local M = {}

M.merge_tb = function(table1, table2)
	return vim.tbl_deep_extend("force", table1, table2)
end

M.goto_buffer = function(buf_idx)
	local active_bufs = get_active_buffers()
	local selected_buf = active_bufs[buf_idx]
	if selected_buf then
		open_buf_id(selected_buf)
	end
end

M.goto_next_buffer = function()
	local active_bufs = get_active_buffers()
	local current_buf_id = vim.api.nvim_get_current_buf()
	local total_bufs = #active_bufs
	local buf_idx = find_buffer(current_buf_id, active_bufs)
	if buf_idx == nil then
		-- TODO: keep track of last used buffer
		buf_idx = 0
	end
	local next_buf_idx = (buf_idx + 1) % (total_bufs + 1)
	if next_buf_idx == 0 then
		next_buf_idx = 1
	end
	M.goto_buffer(next_buf_idx)
end

M.goto_prev_buffer = function()
	local active_bufs = get_active_buffers()
	local current_buf_id = vim.api.nvim_get_current_buf()
	local total_bufs = #active_bufs
	local buf_idx = find_buffer(current_buf_id, active_bufs)
	if buf_idx == nil then
		-- TODO: keep track of last used buffer
		buf_idx = 0
	end
	local prev_buf_idx = (buf_idx - 1) % (total_bufs + 1)
	if prev_buf_idx == 0 then
		prev_buf_idx = total_bufs
	end
	M.goto_buffer(prev_buf_idx)
end

return M
