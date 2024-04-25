return {
    "mfussenegger/nvim-dap",
    lazy = false,
    enabled = true,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtual_text = require("nvim-dap-virtual-text")

        dap.adapters.lldb = {
            type = 'executable',
            command = '/usr/bin/lldb-vscode-10', -- adjust as needed, must be absolute path
            name = 'lldb'
        }

        local lldb_launch = {
            name = "Launch lldb",
            type = "lldb", -- matches the adapter
            request = "launch", -- could also attach to a currently running process
            program = function()
                return vim.fn.input(
                    "Path to executable: ",
                    vim.fn.getcwd() .. "/",
                    "file"
                )
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
        }
        local lldb_attach = {
            -- If you get an "Operation not permitted" error using this, try disabling YAMA:
            --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            name = "Attach to process",
            type = 'lldb',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
            request = 'attach',
            pid = require('dap.utils').pick_process,
            args = {},
        }

        dap.configurations.cpp = {
            lldb_attach
        }
        dap.configurations.rust = {
            lldb_attach,
            initCommands = function()
            -- Find out where to look for the pretty printer Python module
            local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

            local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
            local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

            local commands = {}
            local file = io.open(commands_file, 'r')
            if file then
              for line in file:lines() do
                table.insert(commands, line)
              end
              file:close()
            end
            table.insert(commands, 1, script_import)

            return commands
            end,
        }

        dapui.setup()
        virtual_text.setup()
    end
}
