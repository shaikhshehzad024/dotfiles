return {
  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    opts = {},
  },
  {
    "mistricky/codesnap.nvim",
    lazy = "true",
    build = "make",
    cmd = "CodeSnapPreviewOn",
    config = function(_,opts)
      require("codesnap").setup(opts)
    end
  },
}
