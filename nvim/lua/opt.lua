-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

-- tab is a four character \t
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = false
vim.opt.textwidth = 80

vim.opt.wrap = false

vim.opt.swapfile = true
vim.opt.dir = os.getenv("HOME") .. "/.tmp/nvim/swap/"
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.tmp/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- change comment color
vim.api.nvim_set_hl(0, "Comment", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        --signs = { severity_limit = "Error", },
        --virtual_text = { 
        --    spacing = 4, 
        --    severity_limit = "Error",
        --},
        signs = false,
        virtual_text = false,
        underline = false,
        update_in_insert = false,
    }
)

--
-- VimTex
--
-- Enable filetype detection, plugin loading, and indentation
vim.cmd('filetype plugin indent on')

-- Enable syntax highlighting and features
vim.cmd('syntax enable')

-- Configure VimTeX viewer options
vim.g.vimtex_view_method = 'zathura'  -- Use zathura as the viewer

-- Or configure the general viewer options
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

-- Set the default compiler backend for VimTeX (latexmk is the default)
vim.g.vimtex_compiler_method = 'latexmk'  -- Use latexmk as the compiler method
