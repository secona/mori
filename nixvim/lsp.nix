{ ... }:

{
  # TODO
  # crates.nvim
  plugins.lsp = {
    enable = true;
    capabilities = ''
      capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
    '';

  };

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