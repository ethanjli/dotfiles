vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      timeout = 500,
    })
  end,
})

require("ibl").setup()

require("Comment").setup()

require("todo-comments").setup({
  signs = false,
  highlight = {
    keyword = "bg", -- workaround for https://github.com/folke/todo-comments.nvim/issues/10#issuecomment-920953839
    pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
  },
  search = {
    pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
  },
})
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_next()
end, { desc = "Previous todo comment" })

require("scope").setup({})

require("mini.ai").setup({ n_lines = 500 })
require("mini.surround").setup()
