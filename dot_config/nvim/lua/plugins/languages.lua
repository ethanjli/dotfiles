return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ':TSUpdate',
	},
	"mason-org/mason.nvim",
	"neovim/nvim-lspconfig",
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
	},
	"zapling/mason-conform.nvim",
	"tpope/vim-sleuth",
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
}
