{ ... }:

{
  # TODO
  # crates.nvim
  # lsp

  plugins.fidget = {
    enable = true;
    notification = {
      window = {
        maxWidth = 50;
        winblend = 0;
        border = "rounded";
      };
    };
  };

  plugins.conform-nvim = {
    enable = true;
    formattersByFt = {
      javascript = [ "prettier" ];
      javascriptreact = [ "prettier" ];
      typescript = [ "prettier" ];
      typescriptreact = [ "prettier" ];
      go = [ "goimports" "gofmt" ];
      rust = [ "rustfmt" ];
      json = [ "jq" ];
      lua = [ "stylua" ];
    };

    # TODO
    # <leader> fm
  };
}