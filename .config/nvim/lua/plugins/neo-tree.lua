-- Neo-tree (file browser)
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            event_handlers = {
                {
                    event = "file_open_requested",
                    handler = function(file_path)
                        require("neo-tree.command").execute({ action = "close" })
                        return { handled = false }
                    end
                },
            }
        })
    end
}
