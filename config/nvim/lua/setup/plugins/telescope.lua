function printTable(t, f)

   local function printTableHelper(obj, cnt)

      local cnt = cnt or 0

      if type(obj) == "table" then

         io.write("\n", string.rep("\t", cnt), "{\n")
         cnt = cnt + 1

         for k,v in pairs(obj) do

            if type(k) == "string" then
               io.write(string.rep("\t",cnt), '["'..k..'"]', ' = ')
            end

            if type(k) == "number" then
               io.write(string.rep("\t",cnt), "["..k.."]", " = ")
            end

            printTableHelper(v, cnt)
            io.write(",\n")
         end

         cnt = cnt-1
         io.write(string.rep("\t", cnt), "}")

      elseif type(obj) == "string" then
         io.write(string.format("%q", obj))

      elseif type(obj) == "function" then
        -- Handle function type
        io.write("function: ", tostring(obj))

      else
         io.write(tostring(obj))
      end 
   end

   if f == nil then
      printTableHelper(t)
   else
      io.output(f)
      io.write("return")
      printTableHelper(t)
      io.output(io.stdout)
   end
end
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
    -- keymap.set('n', '<leader>sfh', builtin.find_files, {hidden = true}, { desc = '[S]earch [F]iles including hidden files' })
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
    keymap.set("n", "<Leader>sx", function ()
      local mappings = vim.api.nvim_get_keymap('n')  -- Get normal mode mappings
        printTable(mappings,"test.txt")
    end, {silent = true})
  end,
}
