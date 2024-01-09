return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
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
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      live_grep = {
        file_ignore_patterns = { "node_modules", ".git", ".venv" },
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      defaults = {
        path_display = { "truncate " },
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    telescope.load_extension "fzf"

    local keymap = vim.keymap -- for conciseness
    local builtin = require "telescope.builtin"

    local harpoon = require('telescope').load_extension('harpoon')
    local git_worktree = require('telescope').load_extension('git_worktree')
    local notify = require('telescope').load_extension('notify')

    -- See `:help telescope.builtin`
    keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
    keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer]' })

    keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
    keymap.set('n', '<leader>sS', builtin.git_status, { desc = '' })
    keymap.set('n', '<leader>sm', harpoon.marks, { desc = 'Harpoon [M]arks' })
    keymap.set("n", "<Leader>sr", git_worktree.git_worktrees, {silent = true})
    keymap.set("n", "<Leader>sR", git_worktree.create_git_worktree, {silent = true})
    keymap.set("n", "<Leader>sn", notify.notify, {silent = true})
  end,
}
