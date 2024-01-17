local utils = require("utils")
local nmap = utils.nmap
local vmap = utils.vmap
local imap = utils.imap
local xmap = utils.xmap
local omap = utils.omap
local nnoremap = utils.nnoremap
local inoremap = utils.inoremap
local vnoremap = utils.vnoremap

-- Mappings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
nmap("<Space>", "<Nop>", { silent = true })
vmap("<Space>", "<Nop>", { silent = true })

vim.opt.pastetoggle = "<leader>v"

nnoremap("Q", "<nop>")
inoremap("jk", "<Esc>")
nmap("QQ", ":q!<enter>")
nmap("WW", ":w!<enter>")
nmap("E", "$")
nmap("B", "^")
nnoremap("TT", ":TransparentToggle<CR>")
nnoremap("st", ":TodoTelescope<CR>")
nmap("ss", ":silent set hlsearch! hlsearch?<cr>")

nmap("<leader><space>", [[:%s/\s\+$<cr>]])
nmap("<leader><space><space>", [[:%s/\n\{2,}/\r\r/g<cr>]])

nmap("<leader>l", ":set list!<cr>")
inoremap("<C-j>", [[v:lua.completion_nvim.smart_pumvisible('<C-n>', '<C-j>')]], { expr = true })
inoremap("<C-k>", [[v:lua.completion_nvim.smart_pumvisible('<C-p>', '<C-k>')]], { expr = true })
vmap("<", "<gv")
vmap(">", ">gv")
nmap("<leader>.", "<c-^>")
vmap(".", ":normal .<cr>")

nmap("<S-h>", "<Plug>WinMoveLeft")
nmap("<S-j>", "<Plug>WinMoveDown")
nmap("<S-k>", "<Plug>WinMoveUp")
nmap("<S-l>", "<Plug>WinMoveRight")

-- helpers for dealing with other people's code
nmap([[\t]], ":set ts=4 sts=4 sw=4 noet<cr>")
nmap([[\s]], ":set ts=4 sts=4 sw=4 et<cr>")

nmap("<leader>z", "<Plug>Zoom")

-- move line mappings
local opt_h = "˙"
local opt_j = "∆"
local opt_k = "˚"
local opt_l = "¬"

nnoremap(opt_h, ":cprev<cr>zz")
nnoremap(opt_l, ":cnext<cr>zz")

nnoremap(opt_j, ":m .+1<cr>==")
nnoremap(opt_k, ":m .-2<cr>==")
inoremap(opt_j, "<Esc>:m .+1<cr>==gi")
inoremap(opt_k, "<Esc>:m .-2<cr>==gi")
vnoremap(opt_j, ":m '>+1<cr>gv=gv")
vnoremap(opt_k, ":m '<-2<cr>gv=gv")

-- wrap visual selection in provided wrapper
vnoremap("$(", "<esc>`>a)<esc>`<i(<esc>") -- wrap in parentheses
vnoremap("$[", "<esc>`>a]<esc>`<i[<esc>") -- wrap in brackets
vnoremap("${", "<esc>`>a}<esc>`<i{<esc>") -- wrap in braces
vnoremap([[$']], [[<esc>`>a"<esc>`<i"<esc>]]) -- wrap in quotes
vnoremap("$'", "<esc>`>a'<esc>`<i'<esc>") -- wrap in single quotes
vnoremap([[$\]], "<esc>`>o*/<esc>`<O/*<esc>")
vnoremap([[$<]], "<esc>`>a><esc>`<i<<esc>")

-- toggle cursorline
nmap("<leader>i", ":set cursorline!<cr>")

-- scroll the viewport faster
nnoremap("<C-e>", "3<c-e>")
nnoremap("<C-y>", "3<c-y>")

-- moving up and down work as you would expect
nnoremap("j", 'v:count == 0 ? "gj" : "j"', { expr = true })
nnoremap("k", 'v:count == 0 ? "gk" : "k"', { expr = true })
nnoremap("^", 'v:count == 0 ? "g^" :  "^"', { expr = true })
nnoremap("$", 'v:count == 0 ? "g$" : "$"', { expr = true })

-- custom text objects
-- inner-line
xmap("il", ":<c-u>normal! g_v^<cr>")
omap("il", ":<c-u>normal! g_v^<cr>")
-- around line
vmap("al", ":<c-u>normal! $v0<cr>")
omap("al", ":<c-u>normal! $v0<cr>")

-- interesting word mappings
nmap("<leader>0", "<Plug>ClearInterestingWord")
nmap("<leader>1", "<Plug>HiInterestingWord1")
nmap("<leader>2", "<Plug>HiInterestingWord2")
nmap("<leader>3", "<Plug>HiInterestingWord3")
nmap("<leader>4", "<Plug>HiInterestingWord4")
nmap("<leader>5", "<Plug>HiInterestingWord5")
nmap("<leader>6", "<Plug>HiInterestingWord6")

nmap("<leader>pv", vim.cmd.Ex)

-- Normal Mode Key Mappings

-- Move down half a screen and center
nmap("<C-d>", "<C-d>zz")
-- <C-d>: Moves the window down half a screen.
-- zz: Centers the line with the cursor in the middle of the window.

-- Move up half a screen and center
nmap("<C-u>", "<C-u>zz")
-- <C-u>: Moves the window up half a screen.
-- zz: Centers the line with the cursor in the middle of the window.

-- Repeat search forward, center and open folds
-- nmap("n", "nzzzv")
-- n: Repeat the last search, moving to the next match.
-- zz: Centers the line with the cursor in the window.
-- zv: Opens up any folded text at the cursor.

-- Repeat search backward, center and open folds
nmap("N", "Nzzzv")
-- N: Repeat the last search, moving to the previous match.
-- zz: Centers the line with the cursor in the window.
-- zv: Opens up any folded text at the cursor.

-- Join lines and return to original position
nmap("J", "mzJ`z")
-- mz: Sets a mark at the current cursor position with the name 'z'.
-- J: Joins the current line with the next line.
-- `z: Moves the cursor back to the mark 'z'.

-- Disable Q in normal mode
nmap("Q", "<nop>")

-- Format buffer using LSP
nmap("<leader>f", vim.lsp.buf.format)

-- Quickfix and Location List Navigation
-- nmap("<C-k>", "<cmd>cnext<CR>zz")
-- nmap("<C-j>", "<cmd>cprev<CR>zz")
-- nmap("<leader>k", "<cmd>lnext<CR>zz")
-- nmap("<leader>j", "<cmd>lprev<CR>zz")
-- <C-k>, <C-j>: Navigate through quickfix list items.
-- <leader>k, <leader>j: Navigate through location list items.
-- zz: Centers the cursor line in the middle of the window.

-- Substitute word under cursor
nmap("<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make file executable
nmap("<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Visual Mode Key Mappings

-- Move selected line(s) down
vmap("J", ":m '>+1<CR>gv=gv")
-- :m '>+1: Move the selected block one line down.
-- gv=gv: Reselect the block and reindent.

-- Move selected line(s) up
vmap("K", ":m '<-2<CR>gv=gv")
-- :m '<-2: Move the selected block one line up.
-- gv=gv: Reselect the block and reindent.

-- Greatest remap for cut in visual mode
vmap("<leader>p", [["_dP]])
-- [["_d: Delete into the black hole register (no yank).
-- P: Put before the cursor.

-- Yank and Delete Remaps for Normal and Visual Modes
nmap("<leader>y", [["+y]])
vmap("<leader>y", [["+y]])
nmap("<leader>Y", [["+Y]])
nmap("<leader>d", [["_d]])
vmap("<leader>d", [["_d]])
-- <leader>y, <leader>Y: Yank to system clipboard.
-- <leader>d: Delete without yanking.

nmap("<leader>df", utils.confirm_and_delete_buffer, { desc = "Delete file" })
-- open current buffer in a new tab
nmap("gTT", ":tab sb<cr>")

nmap("<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
