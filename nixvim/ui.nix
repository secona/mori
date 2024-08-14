{ ... }:

{
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavor = "mocha";
      transparent_background = true;
      color_overrides = {
        mocha = {
          base = "#000000";
        };
      };
      integrations = {
        barbar = true;
        gitsigns = true;
        barbecue = {
          dim_dirname = true;
          bold_basename = true;
          dim_context = false;
          alt_background = false;
        };
        mason = true;
        nvimtree = true;
        neotree = true;
        treesitter = true;
        treesitter_context = true;
        lsp_trouble = true;
        cmp = true;
        illuminate = {
          enabled = true;
          lsp = false;
        };
        rainbow_delimiters = true;
        which_key = true;
        fidget = true;
        telescope = {
          enabled = true;
          style = "nvchad";
        };
      };
    };
  };

  plugins.lualine = {
    enable = true;
  };

  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "▏";
      };
    };
  };

  plugins.dressing = {
    enable = true;
  };

  plugins.illuminate = {
    enable = true;
  };

  # TODO
  # nvim-scrollbar
  # nvim-hlslens
  # reactive.nvim
}