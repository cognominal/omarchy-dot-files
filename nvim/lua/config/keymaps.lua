-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Follow a markdown [text](path) link found anywhere on the current line,
-- without needing the cursor positioned inside the (...) part.
vim.keymap.set("n", "gl", function()
  local line = vim.api.nvim_get_current_line()
  local path = line:match("%[.-%]%((.-)%)")
  if not path then
    vim.notify("No markdown link found on this line", vim.log.levels.WARN)
    return
  end
  path = path:match("^(%S+)") or path -- drop optional "title" after the path
  if path:match("^https?://") then
    vim.ui.open(path)
  else
    vim.cmd.edit(vim.fn.expand("%:p:h") .. "/" .. path)
  end
end, { desc = "Follow markdown link on line" })

-- Copy all diagnostic messages on the current line to the system clipboard.
vim.keymap.set("n", "<leader>cy", function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diagnostics == 0 then
    vim.notify("No diagnostics on this line", vim.log.levels.WARN)
    return
  end
  local messages = {}
  for _, d in ipairs(diagnostics) do
    table.insert(messages, d.message)
  end
  vim.fn.setreg("+", table.concat(messages, "\n"))
  vim.notify("Copied diagnostic to clipboard", vim.log.levels.INFO)
end, { desc = "Copy line diagnostic(s) to clipboard" })
