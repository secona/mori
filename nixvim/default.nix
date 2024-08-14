{ ... }:

{
  imports = [
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

  globals = {
    mapleader = "<Space>";
  };

  opts = {
    number = true;
    relativenumber = true;
    tabstop = 4;
    shiftwidth = 4;
    scrolloff = 3;
    signcolumn = "yes";
    wrap = false;
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
  ];
}