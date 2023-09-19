return {
    -- colorschemes
    -- "nanotech/jellybeans.vim",
    "rktjmp/lush.nvim",
    "metalelf0/jellybeans-nvim",

    "morhetz/gruvbox",
    "lunarvim/darkplus.nvim",
    "agude/vim-eldar",
    "folke/tokyonight.nvim",
    "joshdick/onedark.vim",
    "altercation/vim-colors-solarized",
    "tomasr/molokai",
    "NLKNguyen/papercolor-theme",
    {
        "nanotech/jellybeans.vim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            --vim.cmd([[colorscheme jellybeans]])
            vim.cmd [[
            try
            colorscheme jellybeans
            catch /^Vim\%((\a\+)\)\=:E185/
            colorscheme default
            set background=dark
            endtry
            ]]
        end,
    },
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('bamboo').setup {
                -- optional configuration here
            }
            require('bamboo').load()
        end,
    },
}
