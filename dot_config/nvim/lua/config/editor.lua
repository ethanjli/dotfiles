vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 500,
    })
  end,
})

require("marks").setup()

vim.diagnostic.config({
  -- virtual text adds visual clutter, and there's no clean way to move it past the 100-character
  -- line if the line is longer than 100 characters or if there are multiple error markers on the
  -- same line - so we'll just disable it for now:
  virtual_text = false,
})

require("ibl").setup()

require("Comment").setup()

require("todo-comments").setup({
  signs = false,
  highlight = {
    keyword = "bg", -- workaround for https://github.com/folke/todo-comments.nvim/issues/10#issuecomment-920953839
    pattern = [[.*<(KEYWORDS)\s*(\([^\)]*\))?:]],
  },
  search = {
    pattern = [[\b(KEYWORDS)\s*(\([^\)]*\))?:]],
  },
})
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_next()
end, { desc = "Previous todo comment" })

require("mini.ai").setup({ n_lines = 500 })
