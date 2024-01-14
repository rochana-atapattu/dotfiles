return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    {
      "debugloop/telescope-undo.nvim",
      keys = { { "<leader>U", "<cmd>Telescope undo<cr>" } },
      config = function()
        require("telescope").load_extension "undo"
      end,
    },
  },
  keys = {
        { "<leader>/",  '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = "Buffer search", },
        { "<leader>fb", '<cmd>Telescope buffers<cr>',                   desc = "Buffers", },
        { "<leader>fgc", '<cmd>Telescope git_commits<cr>',               desc = "Commits", },
        { "<leader>ff", '<cmd>Telescope find_files<cr>',                desc = "Find All Files", },
        { "<C-p>",      '<cmd>Telescope git_files<cr>',                 desc = "Git files", },
        { "<leader>fh", '<cmd>Telescope help_tags<cr>',                 desc = "Help", },
        { "<leader>fj", '<cmd>Telescope command_history<cr>',           desc = "History", },
        { "<leader>fk", '<cmd>Telescope keymaps<cr>',                   desc = "Keymaps", },
        { "<leader>fl", '<cmd>Telescope lsp_references<cr>',            desc = "Lsp References", },
        { "<leader>fo", '<cmd>Telescope oldfiles<cr>',                  desc = "Old files", },
        { "<leader>fg", '<cmd>Telescope live_grep<cr>',                 desc = "Ripgrep", },
        { "<leader>fs", '<cmd>Telescope grep_string<cr>',               desc = "Grep String", },
        { "<leader>ft", '<cmd>Telescope treesitter<cr>',                desc = "Treesitter", },
    },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      pickers = {
        live_grep = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          -- additional_args = function(_)
          --   return { "--hidden" }
          -- end,
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git', '.venv' },
          hidden = true
        }
      },
      extensions = {
        "fzf"
      },
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.close,
            -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    telescope.load_extension("fzf")

    local keymap = vim.keymap -- for conciseness
    local builtin = require "telescope.builtin"

    local harpoon = require('telescope').load_extension('harpoon')
    local git_worktree = require('telescope').load_extension('git_worktree')
    local notify = require('telescope').load_extension('notify')
    require("telescope").load_extension("noice")
    -- See `:help telescope.builtin`
    keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer]' })

    keymap.set("n", "<Leader><tab>", builtin.commands, {noremap=false})
    -- keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    -- keymap.set('n', '<leader>sgf', builtin.git_files, { desc = '[S]earch [G]it [F]iles' })
    -- keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    -- keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    -- keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    -- keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
    -- keymap.set('n', '<leader>sS', builtin.git_status, { desc = '' })
    keymap.set('n', '<leader>fB', builtin.git_branches, { desc = '' })
    keymap.set('n', '<leader>fm', harpoon.marks, { desc = 'Harpoon [M]arks' })
    keymap.set("n", "<leader>fr", git_worktree.git_worktrees, { silent = true })
    keymap.set("n", "<leader>fR", git_worktree.create_git_worktree, { silent = true })
    keymap.set("n", "<leader>fn", notify.notify, { silent = true })
    -- keymap.set("n", "<leader>snh", function()
    --   require("noice").cmd("history")
    -- end)
  end,
}
