return{
  "voldikss/vim-floaterm",

  config = function ()
    local keymap = vim.keymap
    
    vim.g.floaterm_width = 0.95
    vim.g.floaterm_height = 0.95

    keymap.set('n', '<leader>g', ':FloatermNew lazygit<CR>')
    keymap.set('n', '<leader>t', ':FloatermToggle<CR>')
    keymap.set('n', '<leader>tt', ':FloatermNew<CR>')
    
    -- Normal mode mappings
    keymap.set('n', '<leader>tt', ':FloatermNew<CR>', { noremap = true, silent = true })
    keymap.set('n', '<leader>tp', ':FloatermPrev<CR>', { noremap = true, silent = true })
    keymap.set('n', '<leader>tn', ':FloatermNext<CR>', { noremap = true, silent = true })
    keymap.set('n', '<leader>t', ':FloatermToggle<CR>', { noremap = true, silent = true })
    
    keymap.set('t', '<leader>tt', '<C-\\><C-n>:FloatermNew<CR>', { noremap = true, silent = true })
    keymap.set('t', '<leader>tp', '<C-\\><C-n>:FloatermPrev<CR>', { noremap = true, silent = true })
    keymap.set('t', '<leader>tn', '<C-\\><C-n>:FloatermNext<CR>', { noremap = true, silent = true })
    keymap.set('t', '<leader>t', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

    
  end
}
