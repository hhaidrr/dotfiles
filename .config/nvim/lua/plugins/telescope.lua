local vim = vim

local keymap = {
    files = '<leader>ff',
    buffers = '<leader>fb',
    help_tags = '<leader>fh',
    marks = '<leader>fm',
    live_grep_args = '<leader>fs',
    lsp_references = 'gr',
    lsp_definitions = 'gd',
    diagnostics = '<leader>dd',
}

local key_load_events = {}
for _, value in pairs(keymap) do
    table.insert(key_load_events, value)
end

return {
    'nvim-telescope/telescope.nvim',
    keys = key_load_events,
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },
        { "nvim-tree/nvim-web-devicons" },

    },
    config = function()
        local actions = require('telescope.actions')
        local telescope = require('telescope')
        local lga_actions = require("telescope-live-grep-args.actions")
        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-c>"] = false,
                    },
                    n = {
                        ["q"] = actions.close,
                    }
                },
            },
            pickers = {
                live_grep = {
                    only_sort_text = true
                }
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = {         -- extend mappings
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            -- freeze the current list and start a fuzzy search in the frozen list
                            ["<C-space>"] = lga_actions.to_fuzzy_refine,
                        },
                    },
                    -- ... also accepts theme settings, for example:
                    -- theme = "dropdown", -- use dropdown theme
                    -- theme = { }, -- use own theme spec
                    -- layout_config = { mirror=true }, -- mirror preview pane
                }
            }
        })

        local tb = require('telescope.builtin')
        local live_grep_args_module = require('telescope').extensions.live_grep_args

        vim.keymap.set('n', keymap.files, tb.find_files, { desc = 'Telescope find files' })

        vim.keymap.set('n', keymap.buffers, tb.buffers, { desc = 'Telescope buffers' })

        vim.keymap.set('n', keymap.help_tags, tb.help_tags, { desc = 'Telescope help tags' })

        vim.keymap.set('n', keymap.marks, tb.marks, { desc = 'Telescope marks' })

        vim.keymap.set("n", keymap.live_grep_args, live_grep_args_module.live_grep_args,
            { desc = 'Telescope live grep args' })

        vim.keymap.set('n', keymap.lsp_references, tb.lsp_references,
            { noremap = true, silent = true, desc = 'Telescope LSP references' })

        vim.keymap.set('n', keymap.lsp_definitions, tb.lsp_definitions,
            { noremap = true, silent = true, desc = 'Telescope LSP definitions' })

        vim.keymap.set('n', keymap.diagnostics, function()
            tb.diagnostics({
                bufnr = 0,
            })
        end, { noremap = true, silent = true, desc = 'Telescope diagnostics' })
    end



}
