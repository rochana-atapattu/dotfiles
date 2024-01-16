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
vim.opt.pastetoggle = "<leader>v"

nnoremap("Q", "<nop>")
imap("jk", "<Esc>")
nmap("<leader>,", ":silent w<cr>")
nmap("<space>", ":silent set hlsearch! hlsearch?<cr>")

nmap("<leader><space>", [[:%s/\s\+$<cr>]])
nmap("<leader><space><space>", [[:%s/\n\{2,}/\r\r/g<cr>]])

nmap("<leader>l", ":set list!<cr>")
inoremap("<C-j>", [[v:lua.completion_nvim.smart_pumvisible('<C-n>', '<C-j>')]], { expr = true })
inoremap("<C-k>", [[v:lua.completion_nvim.smart_pumvisible('<C-p>', '<C-k>')]], { expr = true })
vmap("<", "<gv")
vmap(">", ">gv")
nmap("<leader>.", "<c-^>")
vmap(".", ":normal .<cr>")

nmap("<C-h>", "<Plug>WinMoveLeft")
nmap("<C-j>", "<Plug>WinMoveDown")
nmap("<C-k>", "<Plug>WinMoveUp")
nmap("<C-l>", "<Plug>WinMoveRight")

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

-- open current buffer in a new tab
nmap("gTT", ":tab sb<cr>")
