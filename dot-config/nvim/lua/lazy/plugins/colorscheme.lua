return {
  -- onedark
  {
    "navarasu/onedark.nvim",
    -- options passed to setup() fn
    opts = {
      style = "deep",
      transparent = true,
      term_colors = true,
      ending_tidles = true,
      code_style = {
        comments = "none",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
      colors = {
	      -- main text
	      --fg = "#ffffff",
      },
    },
    lazy = false,
    priority = 1000,
  },
}
