vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.clipboard = "unnamedplus"
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.textwidth = 80

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

local github = function (identifier)
    return "https://github.com/" .. identifier
end

vim.pack.add({
    {
        src = github("saghen/blink.cmp"),
        version = vim.version.range("1.0")
    },
    github("nvim-lua/plenary.nvim"),
    github("tpope/vim-fugitive"),
    github("nvim-telescope/telescope.nvim"),
    github("nvim-telescope/telescope-fzf-native.nvim"),
    github("nvim-telescope/telescope-ui-select.nvim"),
    github("neovim/nvim-lspconfig"),
    github("nvim-mini/mini.nvim"),
    github("nvim-neotest/nvim-nio"),
    github("seffradev/midnight.nvim"),
    github("nvim-treesitter/nvim-treesitter"),
    github("mbbill/undotree"),
    github("christoomey/vim-tmux-navigator"),
    github("nvim-tree/nvim-web-devicons")
})

vim.cmd.colorscheme "midnight"

local telescope = require("telescope")

local statusline = require "mini.statusline"
statusline.setup { use_icons = true }

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            print("No client could be connected")
            return
        end

        if client:supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation ...
        end

        if client:supports_method('textDocument/completion') then
            -- Optional: trigger autocompletion on EVERY keypress. May be slow!
            -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            -- client.server_capabilities.completionProvider.triggerCharacters = chars

            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Auto-format ("lint") on save.
        -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                buffer = args.buf,
                callback = function ()
                    vim.lsp.buf.format({
                        bufnr = args.buf,
                        id = client.id,
                        timeout_ms = 1000
                    })
                end
            })
        end
    end
})

-- Highlight when yanking text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function ()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function ()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

local telescope_builtin = require "telescope.builtin"

telescope.setup {
    defaults = {
        theme = "dropdown",
        sorting_strategy = "ascending",
        layout_strategy = "flex",
        border = true
    },
    extensions = {
        fzf = {},
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    }
}

telescope.load_extension "ui-select"

local treesitter_configs = require "nvim-treesitter"

treesitter_configs.setup {
    ensure_installed = {
        "query",
        "vim",
        "vimdoc"
    },
    sync_install = false,
    auto_install = false,
    ignore_install = {},
    modules = {},
    highlight = {
        enable = true,
        disable = function (_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false
    }
}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

local live_multigrep = function (opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job {
        command_generator = function (prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end

            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end

            return vim.tbl_flatten {
                args,
                {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case"
                }
            }
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Live grep",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require "telescope.sorters".empty()
    }):find()
end

vim.lsp.enable("typos_lsp")
vim.lsp.config("typos_lsp", {})

vim.lsp.enable("harper_ls")
vim.lsp.config("harper_ls", {})

vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

vim.lsp.config("just-lsp", {})
vim.lsp.enable("just-lsp")

vim.lsp.enable("nil_ls")
vim.lsp.config("nil_ls", {})

vim.lsp.enable("emmylua_ls")
vim.lsp.config("emmylua_ls", {
    cmd = { "emmylua_ls" },
    filetypes = { "lua" },
    root_markers = { ".emmyrc.json", ".luarc.json", ".git" }
})

vim.lsp.config("tinymist", {})
vim.lsp.enable("tinymist")

vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {})

vim.lsp.enable("ruff")
vim.lsp.config("ruff", {})

vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
    settings = {
        pyright = {
            disableOrganizeImports = true
        },
        python = {
            analysis = {
                ignore = {
                    "*"
                }
            }
        }
    }
})

require "nvim-treesitter".setup {
    ensure_installed = {
        "c",
        "cpp",
        "just",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "rust",
        "typst"
    }
}

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Source current file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Source current line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Source selection" })

vim.keymap.set("n", "<leader>pv", "<cmd>Explore<CR>", { desc = "Open Netrw" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Move to previous match" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
vim
    .keymap
    .set(
        "n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
        {
            desc = "Substitute word under cursor"
        }
    )

vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "LazyGit" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })

vim.keymap.set("n", "<leader>/", telescope_builtin.current_buffer_fuzzy_find, { desc = "Fuzzy-find current buffer" })
vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "Search git files" })
vim.keymap.set("n", "<leader>gb", telescope_builtin.git_branches, { desc = "Search git branches" })
vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols, { desc = "Search document symbols" })
vim.keymap.set("n", "<leader>fS", telescope_builtin.lsp_workspace_symbols, { desc = "Search workspace symbols" })
vim.keymap.set("n", "<leader>fd", telescope_builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Search files in current working directory" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Search help tags" })
vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references, { desc = "Search symbol references" })
vim.keymap.set("n", "<leader>fR", telescope_builtin.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Search open buffers" })
vim.keymap.set("n", "<leader>fc", telescope_builtin.command_history, { desc = "Search command history" })

vim.keymap.set("n", "<leader>en", function ()
    telescope_builtin.find_files { cwd = vim.fn.stdpath("config") }
end, { desc = "Edit Neovim configuration" }
)

vim.keymap.set("n", "<leader>ep", function ()
    telescope_builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") }
end, { desc = "Search files from Neovim packages" }
)

vim.keymap.set("n", "<leader>fg", function ()
    telescope_builtin.grep_string { search = vim.fn.input "grep: ", hidden = false }
end, { desc = "Grep files in current working directory" }
)

vim.keymap.set("n", "<leader>fG", function ()
    telescope_builtin.grep_string { search = vim.fn.input "grep (hidden): ", hidden = true }
end, { desc = "Grep files (inclusive hidden) in current working directory" }
)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree view" })

vim.keymap.set('n', '<C-h>', "<cmd>TmuxNavigateLeft<CR>")
vim.keymap.set('n', '<C-j>', "<cmd>TmuxNavigateDown<CR>")
vim.keymap.set('n', '<C-k>', "<cmd>TmuxNavigateUp<CR>")
vim.keymap.set('n', '<C-l>', "<cmd>TmuxNavigateRight<CR>")
vim.keymap.set('n', '<C-\\>', "<cmd>TmuxNavigatePrevious<CR>")

vim.keymap.set("n", "<leader>fl", function ()
    live_multigrep(opts)
end, { desc = "Live multigrep" }
)
