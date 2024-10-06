return {
    -- Debug Adapter Protocol plugin
    {
        "mfussenegger/nvim-dap",
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
