require("mason").setup({})
require("trouble").setup({})

local cmp = require("cmp")

-- LSP
local lsp = require("lsp-zero")
local cmp_action = require("lsp-zero").cmp_action()

lsp.preset("recommended")

lsp.set_preferences({
    sign_icons = {}
})

vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

lsp.setup()

local lspconfig = require("lspconfig")

lspconfig.bashls.setup({})
lspconfig.clangd.setup({})
lspconfig.csharp_ls.setup({})
lspconfig.gleam.setup({})
lspconfig.gopls.setup({})
lspconfig.harper_ls.setup({})
lspconfig.htmx.setup({})
lspconfig.intelephense.setup({})
lspconfig.jdtls.setup({})
lspconfig.jsonls.setup({})
lspconfig.lemminx.setup({})
lspconfig.lua_ls.setup({})
lspconfig.mesonlsp.setup({})
lspconfig.sqlls.setup({})
lspconfig.svelte.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.taplo.setup({})
lspconfig.texlab.setup({})
lspconfig.ts_ls.setup({})
lspconfig.vuels.setup({})
lspconfig.yamlls.setup({})
lspconfig.zls.setup({})

-- Python LSP
lspconfig.ruff.setup({})
lspconfig.ruff_lsp.setup({
    on_attach = function(client, _)
        if client.name == "ruff_lsp" then
            client.server_capabilities.hoverProvider = false
        end
    end
})
lspconfig.pyright.setup({
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { "*" },
            }
        }
    }
})

-- Rust LSP
lspconfig.rust_analyzer.setup({
    autostart = true,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            }
        }
    }
})

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("lspkind").init({})

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "luasnip" },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-c>"] = cmp_action.toggle_completion(),
    }),
    snippet = {
        expand = function(args)
            require "luasnip".lsp_expand(args.body)
        end
    },
}

-- Bindings
-- LSP
lsp.on_attach(function(_, bufnr)
    -- Insert mode
    vim.keymap.set("i", "<C-s>", function() vim.lsp.buf.signature_help() end, { desc = "Signature help" })

    -- Normal mode
    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP info" })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show type information" })
    vim.keymap.set("n", "<leader>lw", vim.lsp.buf.workspace_symbol, { desc = "Show workspace symbols" })
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Open diagnostics" })
    vim.keymap.set("n", "<leader>nd", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    vim.keymap.set("n", "<leader>pd", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "Show available code actions" })
    vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "Show references" })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })
    vim.keymap.set("n", "<leader>fws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        { desc = "Show Workspace symbols" })
end)

-- Trouble
vim.keymap.set("n", "<leader>tx", "<cmd>Trouble diagnostic toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=1<cr>", { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)" })
vim.keymap.set("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- LuaSnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })
