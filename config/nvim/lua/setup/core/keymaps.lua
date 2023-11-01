-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<Left>", ":echoerr 'Use h'<CR>", { desc = "Discourage use of Left arrow" })
keymap.set("n", "<Right>", ":echoerr 'Use l'<CR>", { desc = "Discourage use of Right arrow" })
keymap.set("n", "<Up>", ":echoerr 'Use k'<CR>", { desc = "Discourage use of Up arrow" })
keymap.set("n", "<Down>", ":echoerr 'Use j'<CR>", { desc = "Discourage use of Down arrow" })

-- Discourage the use of arrow keys in insert mode
keymap.set("i", "<Left>", "<ESC>:echoerr 'Use h'<CR>", { desc = "Discourage use of Left arrow" })
keymap.set("i", "<Right>", "<ESC>:echoerr 'Use l'<CR>", { desc = "Discourage use of Right arrow" })
keymap.set("i", "<Up>", "<ESC>:echoerr 'Use k'<CR>", { desc = "Discourage use of Up arrow" })
keymap.set("i", "<Down>", "<ESC>:echoerr 'Use j'<CR>", { desc = "Discourage use of Down arrow" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
