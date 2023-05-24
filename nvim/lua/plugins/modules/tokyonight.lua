return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function ()
      -- possible colorschemes are -night -storm -day -moon
      vim.cmd('colorscheme tokyonight-storm')
  end
}
