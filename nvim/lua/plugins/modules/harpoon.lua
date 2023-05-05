return {
    "ThePrimeagen/harpoon",
    config = function ()
        require('harpoon').setup({
          menu = {
            width = vim.api.nvim_win_get_width(0) - 30,
            height = vim.api.nvim_win_get_height(0) - 30,
          }
    })
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
     vim.keymap.set("n", "<leader>ah", mark.add_file)
    -- TODO add to which_key_defaults
    vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
    vim.keymap.set("n", "<C-h>", function() ui.nav_next() end)
    vim.keymap.set("n", "<C-j>", function() ui.nav_prev() end)
    end
}
