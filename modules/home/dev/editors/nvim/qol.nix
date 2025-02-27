{...}: {
  programs.nixvim = {
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

    plugins.vim-surround = {
      enable = true;
    };

    plugins.which-key = {
      enable = true;
      settings.win.border = "single";
    };

    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = {
          action = "find_files";
        };
        "<leader>fg" = {
          action = "live_grep";
        };
        "<leader>fb" = {
          action = "buffers";
        };
        "<leader>fh" = {
          action = "help_tags";
        };
        "<leader>rf" = {
          action = "lsp_references";
        };
      };
    };

    plugins.image = {
      enable = true;
    };
  };
}
