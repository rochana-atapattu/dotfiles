return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = false,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)
					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)
					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hu", gs.undo_stage_hunk)
					map("n", "<leader>hR", gs.reset_buffer)
					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<leader>tb", gs.toggle_current_line_blame)
					map("n", "<leader>hd", gs.diffthis)
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)
					map("n", "<leader>td", gs.toggle_deleted)

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
				end,
			})
		end,
	},
	"github/copilot.vim",
	{
		"ThePrimeagen/git-worktree.nvim",
		dependencies = { "tpope/vim-fugitive" },
		config = function()
			require("git-worktree").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
		keys = {
			{ "<C-g>g", "<cmd>Git<cr>",                     desc = "git" },
			{ "<C-g>r", "<cmd>Gread<cr>",                   desc = "read file from git" },
			{ "<C-g>b", "<cmd>G blame<cr>",                 desc = "read file from git" },
			{ "<C-g>c", "<cmd>Git commit <CR>",             desc = "commit in git",     noremap = false },
			{ "<C-g>f", "<cmd>Git pull<CR>",                desc = "git pull",          noremap = false },
			{ "<C-g>p", "<cmd>Git push -u origin HEAD<CR>", desc = "push to git",       noremap = false },
		},
		dependencies = { "tpope/vim-rhubarb" },
	},
}
