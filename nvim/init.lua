-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Safety net: (re)load config/keymaps.lua on demand if its bindings aren't
-- active yet (e.g. this session started before a keymaps.lua edit).
vim.keymap.set("n", "<leader>rk", function()
  if vim.fn.maparg("gl", "n") == "" then
    package.loaded["config.keymaps"] = nil
    require("config.keymaps")
    vim.notify("Reloaded config.keymaps", vim.log.levels.INFO)
  else
    vim.notify("config.keymaps already loaded", vim.log.levels.INFO)
  end
end, { desc = "Reload keymaps.lua if missing" })
