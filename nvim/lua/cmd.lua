-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd([[colorscheme onedark]])

vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    if args.data.filetype ~= "help" then
      vim.wo.number = true
    elseif args.data.bufname:match("*.csv") then
      vim.wo.wrap = false
    end
  end,
})

vim.cmd("runtime! syntax/c.vim")
vim.cmd("runtime! syntax/cpp.vim")
