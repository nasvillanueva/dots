return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			triggers = {
				"<leader>",
			},
		},
		init = function()
			vim.opt.timeout = true
			vim.opt.timeoutlen = 300
		end,
	},
}
