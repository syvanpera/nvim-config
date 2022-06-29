local packer = require("util.packer")

local config = {
  profile = {
    enable = true,
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  },
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
  opt_default = true,
  -- list of plugins that should be taken from ~/projects
  -- this is NOT packer functionality!
  local_plugins = {},
}

local function plugins(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim" })

  -- Theme: color schemes
  use({
    "folke/tokyonight.nvim",
    opt = false,
    -- event = "VimEnter",
    config = [[require("config.theme")]],
  })

  -- Theme: icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = [[require("nvim-web-devicons").setup({ default = true })]],
  })


  use({ "christoomey/vim-tmux-navigator", opt = false })

  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = [[require("config.tree")]],
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    requires = {
      { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = [[require('config.treesitter')]],
  })

  use({
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    wants = "nvim-treesitter",
    module = "nvim-gps",
    config = [[require("nvim-gps").setup({ separator = " " })]],
  })

  use({
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    wants = "nvim-web-devicons",
    config = [[require("config.lualine")]],
  })

end

return packer.setup(config, plugins)
