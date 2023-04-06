-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = {
    enable = true,
    disable = { "yaml" },
  },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = {
    enable = true,
    disable = { "yaml" },
  },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "markdown",
    "svelte",
    "graphql",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
    "hcl",
    "go",
    "gomod",
    "python",
    "dockerfile",
    "make",
  },
  -- auto install above language parsers
  auto_install = true,
})
