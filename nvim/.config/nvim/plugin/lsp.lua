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
--- LSP
local wk = require("which-key")

lsp.on_attach(function(_, bufnr)
    wk.add({
        { "<leader>l",   group = "LSP",                                      desc = "LSP",                         nowait = true,  remap = false },
        { "<leader>li",  "<cmd>LspInfo<cr>",                                 desc = "LSP info" },
        { "gd",          function() vim.lsp.buf.definition() end,            desc = "Go to definition",            buffer = bufnr, remap = false },
        { "gt",          function() vim.lsp.buf.type_definition() end,       desc = "Go to type definition",       buffer = bufnr, remap = false },
        { "gi",          function() vim.lsp.buf.implementation() end,        desc = "Go to implementation",        buffer = bufnr, remap = false },
        { "K",           function() vim.lsp.buf.hover() end,                 desc = "Show type information",       buffer = bufnr, remap = false },
        { "<leader>lw",  function() vim.lsp.buf.workspace_symbol() end,      desc = "Show workspace symbols",      buffer = bufnr, remap = false },
        { "<leader>ld",  function() vim.diagnostic.open_float() end,         desc = "Open diagnostics",            buffer = bufnr, remap = false },
        { "<leader>nd",  function() vim.diagnostic.goto_next() end,          desc = "Go to next diagnostic",       buffer = bufnr, remap = false },
        { "<leader>pd",  function() vim.diagnostic.goto_prev() end,          desc = "Go to previous diagnostic",   buffer = bufnr, remap = false },
        { "<leader>lc",  function() vim.lsp.buf.code_action() end,           desc = "Show available code actions", buffer = bufnr, remap = false },
        { "<leader>lR",  function() vim.lsp.buf.references() end,            desc = "Show references",             buffer = bufnr, remap = false },
        { "<leader>lr",  function() vim.lsp.buf.rename() end,                desc = "Rename symbol",               buffer = bufnr, remap = false },
        { "<leader>lsh", function() vim.lsp.buf.signature_help() end,        desc = "Signature help",              buffer = bufnr, remap = false },
        { "<leader>lf",  vim.lsp.buf.format,                                 desc = "Format document",             remap = false },
        { "<leader>fws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Show Workspace Symbols",      buffer = bufnr, remap = false },
    })
end)

--- Trouble
wk.add({
    { "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)",                        nowait = true, remap = false },
    { "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=1<cr>",           desc = "Buffer Diagnostics (Trouble)",                 nowait = true, remap = false },
    { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)",                            nowait = true, remap = false },
    { "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", nowait = true, remap = false },
    { "<leader>tL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)",                      nowait = true, remap = false },
    { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)",                      nowait = true, remap = false },
})

--- LuaSnip
local ls = require("luasnip")

vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

