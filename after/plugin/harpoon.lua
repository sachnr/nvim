local harpoon = require("harpoon")

harpoon:setup({
	settings = {
		ui_fallback_width = 40,
		ui_width_ratio = 0.50,
	},
})

vim.keymap.set("n", "<M-h><M-a>", function()
	harpoon:list():add()
end)
vim.keymap.set("n", "<M-h><M-h>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<M-1>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<M-2>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<M-3>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<M-4>", function()
	harpoon:list():select(4)
end)
vim.keymap.set("n", "<M-5", function()
	harpoon:list():select(5)
end)
vim.keymap.set("n", "<M-6>", function()
	harpoon:list():select(6)
end)
vim.keymap.set("n", "<M-7>", function()
	harpoon:list():select(7)
end)
vim.keymap.set("n", "<M-]>", function()
	harpoon:list():next()
end)
vim.keymap.set("n", "<M-[>", function()
	harpoon:list():prev()
end)
