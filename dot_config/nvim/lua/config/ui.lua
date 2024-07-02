require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "auto",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {"encoding", "fileformat", "filetype"}, -- FIXME: hide encoding & fileformat for utf-8 and unix, respectively
    lualine_y = {"diagnostics"},
    lualine_z = {"progress", "location"}
  },
  inactive_sections = {
  },
  tabline = {
    lualine_a = {"mode"},
    lualine_b = {},
    lualine_c = {
      {
        "buffers",
        mode = 4,
      },
    },
    lualine_x = {
      {
        "tabs",
        mode = 0,
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
