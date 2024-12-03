return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			suppressed_dirs = {
				"~/",
				"~/Projects",
				"~/Downloads",
				"~/Dropbox",
				"/",
			},
		},
	},
	{
		"rolv-apneseth/tfm.nvim",
		opts = {
			file_manager = "lf",
			replace_netrw = true,
			enable_cmds = true,
			ui = {
				height = 0.95,
				width = 0.95,
			},
		},
		keys = {
			{ "<leader>lfc", ":Tfm<CR>", desc = "TFM" },
			{ "<leader>lfsp", ":TfmSplit<CR>", desc = "TFM into horizontal split" },
			{ "<leader>lfvs", ":TfmVsplit<CR>", desc = "TFM into vertical split" },
			{ "<leader>lft", ":TfmTabedit<CR>", desc = "TFM into new tab" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lgc", "<cmd>LazyGit<cr>", desc = "LazyGit in CWD" },
			{ "<leader>lgf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit in project root of current file" },
		},
	},
}
