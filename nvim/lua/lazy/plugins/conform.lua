return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    opts = {
          formatters_by_ft = {
            lua = { "stylua" },
            sh = { "shfmt", "shellcheck" },
            perl = { "perltidy" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            cmake = { "cmake_format" },
            go = { "goimports", "gofmt" },
            javascript = { { "prettierd", "prettier" } },

            -- Use the "*" filetype to run formatters on all filetypes.
            ["*"] = { "codespell" },

            -- Use the "_" filetype to run formatters on filetypes that don't
            -- have other formatters configured.
            ["_"] = { "trim_whitespace" },
          },

          -- If this is set, Conform will run the formatter on save.
          -- It will pass the table to conform.format().
          -- This can also be a function that returns the table.
          format_on_save = {
            -- I recommend these options. See :help conform.format for details.
            lsp_fallback = true,
            timeout_ms = 500,
          },

          -- If this is set, Conform will run the formatter asynchronously after save.
          -- It will pass the table to conform.format().
          -- This can also be a function that returns the table.
          format_after_save = {
            lsp_fallback = true,
          },

          -- Set the log level. Use `:ConformInfo` to see the location of the log file.
          log_level = vim.log.levels.ERROR,
          -- Conform will notify you when a formatter errors
          notify_on_error = true,

          -- REVIEW DOC: Custom formatters and changes to built-in formatters
    },
        -- REVIEW DOC: You can set formatters_by_ft and formatters directly
}
