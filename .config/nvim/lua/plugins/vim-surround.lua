return {
    "tpope/vim-surround",
    dependencies = { "tpope/vim-repeat" },
    keys = {
        { 'cs', mode = 'n' }, -- change
        { 'ds', mode = 'n' }, -- delete
        { 'ys', mode = 'n' }, -- select
        { 'S',  mode = 'v' }, -- visual mode
    }
}
