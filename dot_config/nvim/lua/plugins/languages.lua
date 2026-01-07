return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({
				with_sync = true,
			})()
		end,
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
