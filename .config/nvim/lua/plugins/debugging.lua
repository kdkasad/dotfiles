return {
    -- Debug Adapter Protocol plugin
    {
        "mfussenegger/nvim-dap",
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
        end,
    },

    -- DAP UI
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },

    -- Python DAP configuration
    {
        "mfussenegger/nvim-dap-python",
        config = function()
            -- Get debugpy install path from Mason
            local registry = require("mason-registry")
            if registry.is_installed("debugpy") then
                local debugpy_install_path = registry.get_package("debugpy"):get_install_path()
                local venv_path = debugpy_install_path .. "/venv/bin/python"
                require("dap-python").setup(venv_path)
            end
        end,
    },
}
