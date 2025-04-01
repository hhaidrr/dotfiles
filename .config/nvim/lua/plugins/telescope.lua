local vim = vim

return {
    'nvim-telescope/telescope.nvim',
    dependencies={
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        {
            "nvim-telescope/telescope-live-grep-args.nvim" ,
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        },

    },
    config=function ()
        local actions = require('telescope.actions')
        local telescope = require('telescope')
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
        })

        local lga_actions = require("telescope-live-grep-args.actions")
        telescope.setup{
            pickers = {
                live_grep = {
                    only_sort_text = true
                }
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true, -- enable/disable auto-quoting
                    -- define mappings, e.g.
                    mappings = { -- extend mappings
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
        }
        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
--        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Telescope gind files in git' })
        -- vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = 'Telescope live grep' })
--         function ()
--             builtin.grep_string({ search = vim.fn.input("Grep > ") });
--         end,
         -- { desc = 'Telescope live grep' }
         -- )
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set("n", "<leader>fs", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
        telescope.load_extension("live_grep_args")
    end



}
