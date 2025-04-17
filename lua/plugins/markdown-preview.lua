return {
	{
		"iamcco/markdown-preview.nvim",
		lazy = false,
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			-- vim.cmd([[Lazy load markdown-preview.nvim]])
			vim.fn["mkdp#util#install"]()
		end,
	},
}
