local wk = require("which-key")

wk.add({
    { "<leader>d", group = "Debugger", desc = "", nowait = true, remap = false },
})

local dap = require("dap")

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    }
}

local dapui = require("dapui")
dapui.setup()

local overseer = require("overseer")
overseer.setup()

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>db", dapui.toggle, { desc = "Toggle debugger UI" })
vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = "Continue debugged application" })
vim.keymap.set('n', '<Leader>dt', dap.terminate, { desc = "Terminate debugged process" })
vim.keymap.set('n', '<Leader>dr', dap.repl.open, { desc = "Run debugger REPL" })
vim.keymap.set('n', '<Leader>dl', dap.run_last, { desc = "Run last selected debug option" })
vim.keymap.set('n', '<Leader>dso', dap.step_over, { desc = "Step over" })
vim.keymap.set('n', '<Leader>dsi', dap.step_into, { desc = "Step into" })
