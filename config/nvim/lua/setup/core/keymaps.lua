-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- Table to store pane IDs for each direction
local pane_ids = {
  h = "", -- left
  j = "", -- down
  k = "", -- up
  l = "", -- right
}

-- Function to check if a pane exists
local function pane_exists(pane_id)
  if pane_id == "" then
    return false
  end
  local exists = vim.fn.system("tmux list-panes -t " .. pane_id)
  return vim.v.shell_error == 0
end

-- Function to remove a pane ID if it does not exist
local function remove_invalid_pane_id(direction)
  if not pane_exists(pane_ids[direction]) then
    pane_ids[direction] = ""
  end
end

-- Main function to open or reuse a tmux pane
function OpenTmuxPaneToDir(direction)
  local current_line = vim.fn.getline "."
  local path = string.match(current_line, ".* (%S+)$")
  local full_path = vim.fn.fnamemodify(path, ":p")
  local tmux_command = vim.fn.isdirectory(full_path) == 1 and "cd " .. vim.fn.shellescape(full_path)
    or "cd " .. vim.fn.shellescape(vim.fn.fnamemodify(full_path, ":h"))

  remove_invalid_pane_id(direction)

  -- If the pane does not exist or has been closed, create a new one
  if pane_ids[direction] == "" then
    local split_command = direction == "h" and "-h"
      or (direction == "j" and "-v" or (direction == "k" and "-v -b" or "-h -b"))
    pane_ids[direction] = vim.fn.trim(vim.fn.system("tmux split-window " .. split_command .. "P"))
    -- Send the command to the new pane
    if pane_ids[direction] ~= "" then
      vim.fn.system("tmux send-keys -t " .. pane_ids[direction] .. ' "' .. tmux_command .. '" C-m')
    end
  else
    -- Pane exists, send the command to the pane
    vim.fn.system("tmux send-keys -t " .. pane_ids[direction] .. ' "' .. tmux_command .. '" C-m')
  end
end

-- Key mappings
keymap.set("n", "<leader>th", function()
  OpenTmuxPaneToDir "h"
end, { noremap = true, silent = true })
keymap.set("n", "<leader>tj", function()
  OpenTmuxPaneToDir "j"
end, { noremap = true, silent = true })
keymap.set("n", "<leader>tk", function()
  OpenTmuxPaneToDir "k"
end, { noremap = true, silent = true })
keymap.set("n", "<leader>tl", function()
  OpenTmuxPaneToDir "l"
end, { noremap = true, silent = true })

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

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<leader>vwm", function()
  require("vim-with-me").StartVimWithMe()
end)
keymap.set("n", "<leader>svwm", function()
  require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
end)
