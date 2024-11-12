{inputs}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./bufferline.nix
    ./cmp.nix
    ./git.nix
    ./lsp.nix
    ./qol.nix
    ./term.nix
    ./tree.nix
    ./treesitter.nix
    ./ui.nix
  ];

  programs.nixvim = {
    enable = true;

    globals = {
      mapleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      tabstop = 4;
      shiftwidth = 4;
      scrolloff = 3;
      signcolumn = "yes";
      wrap = false;
      fillchars = {eob = " ";};
    };

    keymaps = let
      options = {
        noremap = true;
        silent = true;
      };
    in [
      {
        mode = "i";
        key = "jj";
        action = "<Esc>";
        inherit options;
      }
      {
        mode = "";
        key = "<Space>";
        action = "<Nop>";
        inherit options;
      }
    ];

    plugins.presence-nvim = {
      enable = true;
    };
  };
}
