return {

	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", 	-- Useful lua functions used ny lots of plugins
	{
		"nvim-telescope/telescope.nvim", requires = { {'nvim-lua/plenary.nvim'} } 
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
        build =  'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',

	},
	"BurntSushi/ripgrep",

	--"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	--"akinsho/bufferline.nvim",
	"nvim-lualine/lualine.nvim",
	--"lewis6991/impatient.nvim", -- improve startup time
	"moll/vim-bbye", -- delete buffers/close files without messing up windows
	"tpope/vim-surround",
	"tpope/vim-rails",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"nvim-treesitter/playground",

	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		opts = {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						notes = "~/notes",
					},
				},
			},
		},
	},
	dependencies = { { "nvim-lua/plenary.nvim" } },
},


 "numToStr/Comment.nvim", -- Easily comment stuff
 "JoosepAlviste/nvim-ts-context-commentstring", -- use the right commentstring based on TS context

	{
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
}
