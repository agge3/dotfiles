return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("trouble").setup()
        end,
    },
	{
		"echasnovski/mini.trailspace",
		version = false,
		keys = {
			{ "<leader>tr", "<cmd>lua MiniTrailspace.trim()<cr>", desc = "Trim trailing whitespace", },
		},
		config = function()
			require("mini.trailspace").setup()
		end,
	},
	{
		"ThePrimeagen/vim-apm",
		config = function()
			local apm = require("vim-apm")
			apm:setup({})
			vim.keymap.set("n", "<leader>apm", function()
				apm:toggle_monitor() 
			end)
		end,
	},

    -- one-liners
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "theprimeagen/harpoon" },
    { "luckasRanarison/tree-sitter-hyprlang" },
    --{ "Bekaboo/deadcolumn.nvim" },
    { "lukas-reineke/virt-column.nvim" },
    { "nvim-tree/nvim-tree.lua" },
}
