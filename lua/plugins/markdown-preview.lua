return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = ":call mkdp#util#install()",
	keys = {
		{ "<leader>pm", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
	},
}
