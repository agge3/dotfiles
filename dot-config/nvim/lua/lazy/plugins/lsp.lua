-- manual config with lspconfig OR use lsp-zero
local servers = {
	clangd = { 
		filetypes = { "h", "hpp", "hh", "c", "cpp", "cc", "tpp" },
	},
}

return {    
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- lsp support
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- autocompletion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
		    "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path", -- look into cmp-async-path (if issues)
            "saadparwaiz1/cmp_luasnip",

		    -- snippets
		    "L3MON4D3/LuaSnip",
		    "rafamadriz/friendly-snippets",
        },

        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local default = function(server)
                require("lspconfig")[server].setup({
                    capabilities = capabilities,
					on_attach = on_attach,
					settings = servers[server],
					filetypes = (servers[server] or {}).filetypes,
                })
            end

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                },
                handlers = { default, },
            })

            local cmp = require("cmp")

            cmp.setup({
                sources = { { name = "nvim_lsp", }, },
                mapping = cmp.mapping.preset.insert({
                    -- 'enter' key confirms completion item
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),
                    -- 'ctrl + space' triggers
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
            })
        end,

        keys = {
            -- note: diagnostics are not exclusive to lsp servers
            -- so these can be global keybindings
            vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>'),
            vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>'),
            vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>'),

            vim.api.nvim_create_autocmd('LspAttach', {
              desc = 'LSP actions',
              callback = function(event)
                local opts = {buffer = event.buf}

                -- these will be buffer-local keybindings
                -- because they only work if you have an active language server  
                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
              end
            })
        },
    },
}
