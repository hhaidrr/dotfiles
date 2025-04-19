local ls = require('luasnip')
local types = require('luasnip.util.types')
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")
local python_snips = require("config.module_snippets.python")
local markdown_snips = require("config.module_snippets.markdown")

ls.config.set_config = {
    -- This tells LuaSnip to remember to keep around the last snippet.
    -- You can jump back to it even if you move outside of the selection.
    history = true,

    -- This one is cool because if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",

    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    }
}
-- <c-k> is my expansion key
-- this will expand the current item or jumpo to the next item within the snippet.
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end)

-- <c-j> is my jump backwards key.
-- this alwasy moves to the previous item within the snippet
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/config/luasnip.lua<CR>")

ls.add_snippets("all", {
    s("expand", {
        t("Expanding..."),
    }),
}, { key = "all" })

ls.add_snippets("python", {
    s("d",
        fmt("def {}({}) -> {}:\n\t{}",
            {
                i(1),
                i(2),
                i(3),
                i(4),
            }
        )),
    s("di",
        fmt("def {}(self, {}) -> {}:\n\t{}",
            {
                i(1),
                i(2),
                i(3),
                i(4),
            }
        )),
    s("dp",
        fmt("@property\ndef {}(self) -> {}:\n\t{}",
            {
                i(1),
                i(2),
                i(3),
            }
        )),
    s("dc",
        fmt("@classmethod\ndef {}(cls) -> {}:\n\t{}",
            {
                i(1),
                i(2),
                i(3),
            }
        )),
    s("ds",
        fmt("@staticmethod\ndef {}({}) -> {}:\n\t{}",
            {
                i(1),
                i(2),
                i(3),
                i(4),
            }
        )),
    s("da",
        fmt("@abstractmethod\ndef {}(self) -> {}:\n\t...",
            {
                i(1),
                i(2),
            }
        )),
    -- todo: class
    -- logging config module
    s("lm",
        fmt(python_snips.logging_module,
            {}
        )),
    s("ll",
        fmt(python_snips.logging_local,
            {}
        )),
    s("ld",
        fmt("logger.debug({})",
            {
                i(1),
            }
        )),
    s("lw",
        fmt("logger.warning({})",
            {
                i(1),
            }
        )),
    s("li",
        fmt("logger.info({})",
            {
                i(1),
            }
        )),
    s("le",
        fmt("logger.error({})",
            {
                i(1),
            }
        )),
    s("main",
        fmt(python_snips.main_function,
            {
                i(1),
            }
        )),
    s("ce",
        fmt("class {}(Exception):\n\t\"\"\"{}\"\"\"",
            {
                i(1),
                i(2),
            }
        )),
    -- todo: argparse module
    s("ar",
        fmt(python_snips.argparse_add_argument,
            {
                i(1, "-m"),
                i(2, "--merchant-account"),
                i(3),
                -- use choice node to select between required and optional
                i(4),
                i(5),
            }
        )),
    -- dump service module
    s("dm",
        fmt(python_snips.dump_service,
            {}
        )),
}, { key = "python" })

local javascript_snips = {
    -- logging
    s("ll",
        fmt("console.log({})",
            {
                i(1),
            }
        )),
    s("ld",
        fmt("console.debug({})",
            {
                i(1),
            }
        )),
    s("lw",
        fmt("console.warn({})",
            {
                i(1),
            }
        )),
    s("li",
        fmt("console.info({})",
            {
                i(1),
            }
        )),
    s("le",
        fmt("console.error({})",
            {
                i(1),
            }
        )),
    -- assignments
    s("c",
        fmt("{} {} = {};",
            {
                c(1, {
                    t("const"),
                    t("let"),
                }),
                i(2),
                i(3),
            }
        )),
}
ls.add_snippets("javascript", javascript_snips, { key = "javascript" })
ls.add_snippets("javascriptreact", javascript_snips, { key = "javascriptreact" })


ls.add_snippets("markdown", {
        s("problem",
            fmt(markdown_snips.problem_document,
                {
                    i(1),
                    i(2),
                    i(3),
                    i(4),
                    i(5),
                    i(6),
                    i(7),
                }
            )),
    },
    { key = "markdown" })
