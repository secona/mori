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

    # LSP
  
    {
      mode = "n";
      key = "<F2>";
      action = "vim.lsp.buf.rename";
      inherit options;
    }
    {
      mode = "n";
      key = "<C-Space>";
      action = "vim.lsp.buf.hover";
      inherit options;
    }
    {
      mode = "n";
      key = "<Leader>ee";
      action = "vim.diagnostic.open_float";
      inherit options;
    }
    {
      mode = "n";
      key = "<Leader>ej";
      action = "vim.diagnostic.goto_next";
      inherit options;
    }
    {
      mode = "n";
      key = "<Leader>ek";
      action = "vim.diagnostic.goto_prev";
      inherit options;
    }
    {
      mode = ["n" "v"];
      key = "<Leader>ca";
      action = "vim.lsp.buf.code_action";
      inherit options;
    }
    {
      mode = "n";
      key = "<Leader>dc";
      action = "vim.lsp.buf.declaration";
      inherit options;
    }
    {
      mode = "n";
      key = "<Leader>df";
      action = "vim.lsp.buf.definitions";
      inherit options;
    }
  ];
}