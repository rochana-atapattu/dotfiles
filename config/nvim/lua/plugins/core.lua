return {
	"tpope/vim-commentary",
	"tpope/vim-unimpaired",
	"tpope/vim-surround",
	"tpope/vim-ragtag",
	"tpope/vim-abolish",
	"tpope/vim-repeat",
	"AndrewRadev/splitjoin.vim",
	"tpope/vim-sleuth",
	"editorconfig/editorconfig-vim", -- TODO is this still required?
	"folke/zen-mode.nvim",
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{ "itchyny/vim-qfedit", event = "VeryLazy" },
	{ "windwp/nvim-autopairs", config = true },
	{ "alvarosevilla95/luatab.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- improve the default neovim interfaces, such as refactoring
	{ "stevearc/dressing.nvim", event = "VeryLazy" },

	{
		"nat-418/boole.nvim",
		config = {
			mappings = {
				increment = "<C-a>",
				decrement = "<C-x>",
			},
			-- User defined loops
			additions = {
				-- { "Foo", "Bar" },
				-- { "tic", "tac", "toe" },
			},
			allow_caps_additions = {
				{ "enable", "disable" },
				-- enable → disable
				-- Enable → Disable
				-- ENABLE → DISABLE
			},
		},
	},
}
