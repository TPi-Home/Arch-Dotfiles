return {
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "spectrum", -- or your preferred flavor
        transparent_background = true,
      })
      vim.cmd.colorscheme("monokai-pro")

      -- Force transparency for common groups
      vim.cmd([[
        highlight Normal guibg=none
        highlight NormalFloat guibg=none
        highlight SignColumn guibg=none
        highlight LineNr guibg=none
        highlight EndOfBuffer guibg=none
      ]])
    end,
  },
}
