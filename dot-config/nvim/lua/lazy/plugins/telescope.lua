local builtin = require("telescope.builtin")
return {
  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = vim.fn.executable("make") == 1 and "make"
          or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        enabled = vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1,
      },
      { "nvim-lua/plenary.nvim" },
    },
    -- not working...?
    opt = {
        defaults = {
            layout_config = {
                vertical = { width = 1.0 },
            },
        },
        pickers = {
            live_grep = { theme = "dropdown" },
        },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>",
        desc = "Switch Buffer",
      },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },

      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      
      { "<leader>vo", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>vh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>vc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>va", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },

      { "<leader>m", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>k", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      
      -- find
      { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>r", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      
      vim.keymap.set('n', '<leader>/', builtin.live_grep, {}), 
      vim.keymap.set('n', '<leader>?', builtin.grep_string, {}), 
      vim.keymap.set('n', '<leader><space>', builtin.find_files, {}),
      -- debug/decide on cwd
      --vim.keymap.set('n', '<leader><space><space>', function ()
      --    builtin.find_files({ cwd = true });
      --end),

      vim.keymap.set('n', '<C-c>', builtin.colorscheme, {}),
      vim.keymap.set('n', '<leader>t', builtin.treesitter, {}), 
  },
}
