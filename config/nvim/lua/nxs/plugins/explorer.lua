return {
	{
		"stevearc/oil.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			vim.keymap.set("n", "<leader>1", ":Oil<CR>", { desc = "Open File Explorer" })

			require("oil").setup({
				keymaps = {
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.select",
					-- ["<C-s>"] = "actions.select_vsplit",
					-- ["<C-h>"] = "actions.select_split",
					-- ["<C-t>"] = "actions.select_tab",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-l>"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gs"] = "actions.change_sort",
					["gx"] = "actions.open_external",
					["g."] = "actions.toggle_hidden",
				},
			})
		end,
	},
}
