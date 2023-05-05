return {
    "mbbill/undotree",
    config = function ()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      -- TODO add to which_key_defaults
    end
}
