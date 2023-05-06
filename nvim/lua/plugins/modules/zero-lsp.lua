return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = false,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required

            { 'onsails/lspkind.nvim' },
        },
        config = function()
            local lsp = require('lsp-zero').preset("recommended")

            lsp.ensure_installed({
                'rust_analyzer',
                'clangd',
            })
            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            lsp.skip_server_setup({ 'rust_analyzer' })
            lsp.setup()
        end
    },

    -- inlay hints
    {
        'simrat39/inlay-hints.nvim',
        config = function()
            require("inlay-hints").setup({
                only_current_line = false,
                eol = {
                    right_align = false,
                }
            })
        end
    },

    ------------------------------------
    -- language specific: Rust --
    ------------------------------------
    {
        "simrat39/rust-tools.nvim",
        lazy = false,
        enabled = true,
        config = function()
            local ih = require("inlay-hints")
            -- ih.setup()
            require("rust-tools").setup({
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            check = {
                                command = "clippy",
                            },
                            cargo = {
                                loadOutDirsFromCheck = true,
                            },
                            lens = {
                                enable = true,
                            },
                            procMacro = {
                                enable = true,
                            },
                        },
                    },
                },
                tools = {
                    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
                    reload_workspace_from_cargo_toml = true,
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = false,
                        only_current_line = false,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "<-",
                        other_hints_prefix = "=>",
                        max_len_align = false,
                        max_len_align_padding = 1,
                        right_align = false,
                        right_align_padding = 7,
                        highlight = "Comment",
                    },
                    hover_actions = {
                        border = "rounded",
                    },
                    on_initialized = function()
                        ih.set_all()

                        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                            pattern = { "*.rs" },
                            callback = function()
                                local _, _ = pcall(vim.lsp.codelens.refresh)
                            end,
                        })
                    end,
                },
            })
        end,
    },
    {
        "saecki/crates.nvim",
        version = "v0.3.0",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
                popup = {
                    border = "rounded",
                },
            }
        end,
    },
}
