-- lua language quick guide:   https://learnxinyminutes.com/docs/lua/
-- dependencies: `git`, `unzip`, `ripgrep`, `xclip/xsel`, a nerdfont
vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/site")

-- INFO: options
-- these change the default neovim behaviours using the 'vim.opt' API.
-- see `:h vim.opt` for more details.
-- run `:h '{option_name}'` to see what they do and what values they can take.
-- for example, `:h 'number'` for `vim.opt.number`.

-- must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
-- don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- sync clipboard between OS and Neovim.
--  remove this option if you want your OS clipboard to remain independent.
--  see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"
-- enable break indent
vim.opt.breakindent = true
-- save undo history
vim.opt.undofile = true
-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- decrease update time
vim.opt.updatetime = 250
-- decrease mapped sequence wait time
-- displays which-key popup sooner
vim.opt.timeoutlen = 300
-- configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-- sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- show which line your cursor is on
vim.opt.cursorline = true
-- set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- enable line wrapping
vim.opt.wrap = true
-- formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.textwidth = 80

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
  virtual_text = true, -- show inline diagnostics
})

-- clear search highlights with <Esc>
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- plugins
local plugins = {
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rebelot/kanagawa.nvim",
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    -- The 'build' key ensures parsers update when the plugin updates
    build = ":TSUpdate",
  },
  "https://github.com/neovim/nvim-lspconfig",                     -- default configs for lsps
  "https://github.com/mason-org/mason.nvim",                      -- package manager
  "https://github.com/mason-org/mason-lspconfig.nvim",            -- lspconfig bridge
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim", -- auto installer
  "https://github.com/nvim-lua/plenary.nvim",                     -- library dependency
  "https://github.com/nvim-tree/nvim-web-devicons",               -- icons (nerd font)
  "https://github.com/nvim-telescope/telescope.nvim",             -- the fuzzy finder
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/windwp/nvim-autopairs",    -- auto pairs
  "https://github.com/folke/todo-comments.nvim", -- highlight TODO/INFO/WARN comments
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
  "https://github.com/ThePrimeagen/99",
}

local plugins_opts = {
  { confirm = false },
}

vim.pack.add(plugins, plugins_opts)

vim.cmd.colorscheme("kanagawa")

-- Guard the configuration so it doesn't error out during the first install
local ok, ts_config = pcall(require, "nvim-treesitter.config")
if ok then
  ts_config.setup({
    -- Use the standard Neovim data directory
    install_dir = vim.fn.stdpath("data") .. "/site",
    ensure_installed = {
      "lua",
      "vim",
      "dockerfile",
      "yaml",
      "cpp",
      "bash",
      "markdown",
      "markdown_inline",
      "rust",
      "json",
      "toml",
      "python",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
else
  -- Optional: Notify that setup is deferred until the next restart
  vim.notify("Treesitter downloading... Restart Neovim to complete setup.", vim.log.levels.INFO)
end


-- lsp server installation and configuration
-- see `:h lspconfig-all` for available servers and their settings
local lsp_servers = {
  lua_ls = {
    -- https://luals.github.io/wiki/settings/ | `:h nvim_get_runtime_file`
    Lua = { workspace = { library = vim.api.nvim_get_runtime_file("lua", true) } },
  },
  clangd = {},
  rust_analyzer = {},
}

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-tool-installer").setup({
  ensure_installed = vim.tbl_keys(lsp_servers),
})

-- nvim-cmp setup
---@diagnostic disable-next-line: redundant-parameter
local cmp = require('cmp')
local luasnip = require('luasnip')

-- This annotation tells lua_ls what the table structure should look like
---@type cmp.Config
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- Preset mappings provide a stable base to prevent input stuttering
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Use select = false to prevent Enter from forcing a selection
    -- and potentially double-firing with other plugins
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    -- Improved Tab logic to handle Snippets and Completion safely
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp', priority = 1000 },
    { name = 'luasnip',  priority = 750 },
    { name = 'buffer',   priority = 500 },
    { name = 'path',     priority = 250 },
  }),
})

-- lsp setup
-- We define our nvim-cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Mason installs binaries here
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

-- The new 0.12 way to enable servers
local servers = {
  lua_ls = {
    cmd = { mason_bin .. "lua-language-server" },
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- This makes the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  },
  clangd = { cmd = { mason_bin .. "clangd" } },
  pyright = { cmd = { mason_bin .. "pyright-langserver", "--stdio" } },
  rust_analyzer = { cmd = { mason_bin .. "rust-analyzer" } },
}

-- configure each lsp server on the table
-- to check what clients are attached to the current buffer, use
-- `:checkhealth vim.lsp`. to view default lsp keybindings, use `:h lsp-defaults`.
for name, config in pairs(servers) do
  vim.lsp.config(name, {
    cmd = config.cmd,
    capabilities = capabilities,
    settings = config.settings or {},
    root_markers = { ".git", "package.json", "pyproject.toml", "Cargo.toml" },
  })
  vim.lsp.enable(name)
end

-- lsp keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local function get_opts(keybinding_desc)
      local opts = { buffer = event.buf }
      opts["desc"] = keybinding_desc
      return opts
    end
    -- Jump to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, get_opts("go to def"))
    -- Show documentation (Hover)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, get_opts("show docs"))
    -- Rename symbol across the project
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, get_opts("rename symbol"))
    -- List code actions (fixes, refactors)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, get_opts("list actions"))
    -- Go to references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, get_opts("go to ref"))

    -- Format on save (Optional but popular)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format({ bufnr = event.buf, async = false })
      end,
    })
  end,
})

require("telescope").setup({})

local pickers = require("telescope.builtin")

vim.keymap.set("n", "<leader>sp", pickers.builtin, { desc = "[S]earch Builtin [P]ickers" })
vim.keymap.set("n", "<leader>sb", pickers.buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sf", pickers.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sw", pickers.grep_string, { desc = "[S]earch Current [W]ord" })
vim.keymap.set("n", "<leader>sg", pickers.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sr", pickers.resume, { desc = "[S]earch [R]esume" })

vim.keymap.set("n", "<leader>sh", pickers.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sm", pickers.man_pages, { desc = "[S]earch [M]anuals" })

require("lualine").setup({
  options = {
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
  },
})

require("which-key").setup({
  spec = {
    { "<leader>s", group = "[S]earch", icon = { icon = "", color = "green" } },
  },
})

require("nvim-autopairs").setup()
require("todo-comments").setup()

local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end,
  { desc = "Harpoon add file " })
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  { desc = "Harpoon show list" })

for i = 1, 9 do
  vim.keymap.set("n", "<leader>h" .. i, function() harpoon:list():select(i) end,
    { desc = "select file n." .. i })
end

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
  { desc = "previous file" })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
  { desc = "next file" })

local _99 = require("99")

local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)
_99.setup({
  logger = {
    level = _99.DEBUG,
    type = "file",
    path = "/tmp/" .. basename .. ".99.debug",
    print_on_error = true,
  },
  model = "opencode/big-pickle",
  completion = {
    custom_rules = {},
    source = "cmp",
  },
  md_files = {
    "AGENT.md",
  },
})

vim.keymap.set("n", "<leader>lf", function() _99.fill_in_function_prompt() end, { desc = "99 fill func" })
vim.keymap.set("n", "<leader>la", function() _99.fill_in_function() end, { desc = "99 fill func" })
vim.keymap.set("v", "<leader>lv", function() _99.visual_prompt({}) end, { desc = "99 visual" })
vim.keymap.set("n", "<leader>ls", function() _99.stop_all_requests() end, { desc = "99 stop all" })
vim.keymap.set("v", "<leader>ls", function() _99.stop_all_requests() end, { desc = "99 stop all" })

-- uncomment to enable automatic plugin updates
-- vim.pack.update()
