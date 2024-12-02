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
    lualine_a = {"mode"},
    lualine_b = {
      {
        "filetype",
        on_click = function()
          require("trouble").toggle("lsp_document_symbols")
        end,
      },
    },
    lualine_c = {
      {
        "filename",
        file_status = true,
        newfile_status = true,
        path = 3,
      },
    },
    lualine_x = {
      function()
        return require('auto-session.lib').current_session_name(true)
      end,
      "%{(&fenc!='utf-8'&&&fenc!='')?&fenc:''}", -- don't show file encoding if it's utf-8
      {
        "fileformat",
        icons_enabled = true,
        symbols = {
          unix = "",
          dos = "dos",
          mac = "mac",
        },
      },
      {
        "diagnostics",
        on_click = function()
          vim.diagnostic.setloclist()
        end,
      },
    },
    lualine_y = {
      "progress",
      "location",
    },
    lualine_z = {},
  },
  inactive_sections = {
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "buffers",
        show_filename_only = true,
        mode = 4,
        buffers_color = {
          active = { gui = "bold" },
        },
      },
    },
    lualine_x = {
      {
        "tabs",
        mode = 0,
        tabs_color = {
          active = { gui = "bold" },
        },
      },
    },
    lualine_y = {},
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
})

vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
