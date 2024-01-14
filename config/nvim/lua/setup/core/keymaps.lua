-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = false })
-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- twilight
vim.api.nvim_set_keymap("n", "tw", ":Twilight<enter>", { noremap = false })
-- buffers
vim.api.nvim_set_keymap("n", "tk", ":blast<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tj", ":bfirst<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "th", ":bprev<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "tl", ":bnext<enter>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "td", ":bdelete<enter>", {noremap=false})
-- files
vim.api.nvim_set_keymap("n", "QQ", ":q!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "WW", ":w!<enter>", { noremap = false })
vim.api.nvim_set_keymap("n", "E", "$", { noremap = false })
vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
vim.api.nvim_set_keymap("n", "TT", ":TransparentToggle<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "st", ":TodoTelescope<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", { noremap = true })
-- splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })


-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })



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
-- keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
-- keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                   -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })                 -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                    -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })               -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
-- mz: Sets a mark at the current cursor position with the name 'z'.
-- J: Joins the current line with the next line (standard behavior of J in Vim).
-- `z: Moves the cursor back to the mark 'z', which is the position where it was before joining the lines.
keymap.set("n", "<C-d>", "<C-d>zz")
-- <C-d>: Moves the window down half a screen (standard Vim behavior).
-- zz: Centers the line with the cursor in the middle of the window.
keymap.set("n", "<C-u>", "<C-u>zz")
-- <C-u>: Moves the window up half a screen (standard Vim behavior).
-- zz: Centers the line with the cursor in the middle of the window.
keymap.set("n", "n", "nzzzv")
-- n: Repeat the last search, moving to the next match.
-- zz: Centers the line with the cursor in the window.
-- zv: Opens up any folded text at the cursor.
keymap.set("n", "N", "Nzzzv")
-- N: Repeat the last search, moving to the previous match.
-- zz: Centers the line with the cursor in the window.
-- zv: Opens up any folded text at the cursor.

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- -- The quickfix list in Neovim is typically used to store a list of results from commands like searches or compilations.
-- keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- -- Action: Jumps to the next item in the quickfix list (<cmd>cnext<CR>) and then centers the cursor line in the middle of the window (zz).
-- keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- -- Action: Jumps to the previous item in the quickfix list (<cmd>cprev<CR>) and then centers the cursor line in the middle of the window (zz).
--
-- -- The location list is similar but is local to a window and is often used to store results like search matches or diagnostic messages for a specific file.
-- keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- -- Action: Jumps to the next item in the location list (<cmd>lnext<CR>) and then centers the cursor line in the middle of the window (zz).
-- keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- -- Action: Jumps to the previous item in the location list (<cmd>lprev<CR>) and then centers the cursor line in the middle of the window (zz).\

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
end)

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
