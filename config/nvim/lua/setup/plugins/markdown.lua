return {
  {
  'jakewvincent/mkdnflow.nvim',
  config = function()
    require('mkdnflow').setup({
      -- Config goes here; leave blank for defaults
    })
  end
  },
  {
    "ellisonleao/glow.nvim", 
    config = true,
    cmd = "Glow"
  }
}
