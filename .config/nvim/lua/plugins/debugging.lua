---@type LazySpec[]
return {
    -- Debug Adapter Protocol plugin
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            local dap = require("dap")
            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
            }
            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "Select and attach to process",
                    type = "gdb",
                    request = "attach",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    pid = function()
                        local name = vim.fn.input("Executable name (filter): ")
                        return require("dap.utils").pick_process({ filter = name })
                    end,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Attach to gdbserver :1234",
                    type = "gdb",
                    request = "attach",
                    target = "localhost:1234",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                },
            }
            require("dapui") -- Force nvim-dap-ui to load
            require("mason-nvim-dap") -- Force mason-nvim-dap to load
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dap.listeners.before.attach.dapui_config = dapui.open
            dap.listeners.before.launch.dapui_config = dapui.open
            dap.listeners.before.event_terminated.dapui_config = dapui.close
            dap.listeners.before.event_exited.dapui_config = dapui.close
        end,
    },

    -- Mason-DAP bridge
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        lazy = true,
        event = LazyFile,
        opts = {},
    },

    -- Python DAP configuration
    {
        "mfussenegger/nvim-dap-python",
        lazy = true,
        ft = "python",
        -- Only enable this plugin if debugpy is installed via Mason
        cond = function()
            local success, registry = pcall(require, "mason-registry")
            return success and registry.is_installed("debugpy")
        end,
        config = function()
            -- Get debugpy install path from Mason
            local registry = require("mason-registry")
            local debugpy_install_path = registry.get_package("debugpy"):get_install_path()
            local venv_path = debugpy_install_path .. "/venv/bin/python"
            require("dap-python").setup(venv_path)
        end,
    },
}
