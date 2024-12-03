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
        height = 0.5,
        width = 0.5,
      },
    },
  },
}
