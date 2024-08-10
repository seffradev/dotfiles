return {
    "nvim-telescope/telescope-dap.nvim",
    lazy = false,
    dependencies = {
        "mfussenegger/nvim-dap",
    },
    config = function()
        require("telescope").load_extension("dap")
    end
}
