local opt = vim.opt
local o = vim.o
local env = vim.env

opt.backup = false -- don't use backup files
opt.writebackup = false -- don't backup the file while editing
opt.swapfile = false -- don't create swap files for new buffers
opt.updatecount = 0 -- don't write swap files after some number of updates
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }

opt.directory = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }

opt.history = 1000 -- store the last 1000 commands entered
opt.textwidth = 120 -- after configured number of characters, wrap line

-- show the results of substition as they're happening but don't open a split
opt.inccommand = "nosplit"

opt.backspace = { "indent", "eol,start" } -- make backspace behave in a sane manner
opt.clipboard = { "unnamed", "unnamedplus" } -- use the system clipboard
opt.mouse = "a" -- set mouse mode to all modes

-- searching
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- case-sensitive if expresson contains a capital letter
opt.hlsearch = true -- highlight search results
opt.incsearch = true -- set incremental search, like modern browsers
opt.lazyredraw = false -- don't redraw while executing macros
opt.magic = true -- set magic on, for regular expressions

if vim.fn.executable("rg") then
	-- if ripgrep installed, use that as a grepper
	opt.grepprg = "rg --vimgrep --no-heading"
	opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
	-- create autocmd to automatically open quickfix window when grepping
	vim.cmd([[autocmd QuickFixCmdPost [^l]* nested cwindow]])
end

-- error bells
opt.errorbells = false
opt.visualbell = true
opt.timeoutlen = 500

-- Appearance
---------------------------------------------------------
o.termguicolors = true
opt.number = true -- show line numbers
opt.relativenumber = true
opt.wrap = true -- turn on line wrapping
opt.wrapmargin = 8 -- wrap lines when coming within n characters from side
opt.linebreak = true -- set soft wrapping
opt.showbreak = "↪"
opt.autoindent = true -- automatically set indent of new line
opt.ttyfast = true -- faster redrawing
table.insert(opt.diffopt, "vertical")
table.insert(opt.diffopt, "iwhite")
table.insert(opt.diffopt, "internal")
table.insert(opt.diffopt, "algorithm:patience")
table.insert(opt.diffopt, "hiddenoff")
opt.laststatus = 3 -- show the global statusline all the time
opt.scrolloff = 7 -- set 7 lines to the cursors - when moving vertical
opt.wildmenu = true -- enhanced command line completion
opt.hidden = true -- current buffer can be put into background
opt.showcmd = true -- show incomplete commands
opt.showmode = true -- don't show which mode disabled for PowerLine
opt.wildmode = { "list", "longest" } -- complete files like a shell
opt.shell = env.SHELL
opt.cmdheight = 0 -- hide command bar when not used
opt.title = true -- set terminal title
opt.showmatch = true -- show matching braces
opt.mat = 2 -- how many tenths of a second to blink
opt.updatetime = 300
opt.signcolumn = "yes"
opt.shortmess = "atToOFc" -- prompt message options

-- Tab control
opt.smarttab = true -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
opt.tabstop = 4 -- the visible width of tabs
opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- code folding settings
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
opt.foldnestmax = 10 -- deepest fold is 10 levels
opt.foldenable = false -- don't fold by default
opt.foldlevel = 1
-- fix code folding. Without this autocmd, the message "E490: No fold found" is displayed
-- anytime a fold is triggered, until the file is reloaded (for example, with `:e<cr>`)
-- https://github.com/nvim-telescope/telescope.nvim/issues/699#issuecomment-1159637962
-- vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx" })

-- toggle invisible characters
opt.list = true
opt.listchars = {
	tab = "→ ",
	-- eol = "¬",
	trail = "⋅",
	extends = "❯",
	precedes = "❮",
}

-- hide the ~ character on empty lines at the end of the buffer
opt.fcs = "eob: "
opt.conceallevel = 1
opt.iskeyword:append("-") -- consider string-string as whole word
opt.isfname:append("@-@")
