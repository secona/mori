{ ... }:

{
  plugins.comment = {
    enable = true;
  };

  plugins.nvim-autopairs = {
    enable = true;
  };

  plugins.barbecue = {
    enable = true;
  };

  # TODO
  # vim-visual-multi

  plugins.tmux-navigator = {
    enable = true;
  };

  plugins.sleuth = {
    enable = true;
  };

  plugins.surround = {
    enable = true;
  };

  plugins.which-key = {
    enable = true;
    window.border = "single";
  };

  plugins.telescope = {
    enable = true;
    keymaps = {
      "<Leader>ff" = {
        action = "find_files";
      };
      "<Leader>fg" = {
        action = "live_grep";
      };
      "<Leader>fb" = {
        action = "buffers";
      };
      "<Leader>fh" = {
        action = "help_tags";
      };
      "<Leader>rf" = {
        action = "lsp_references";
      };
    };
  };
}
