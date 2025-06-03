{ ... }:
{
  programs.nixvim = {
    plugins.rustaceanvim = {
      enable = false;
    };

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

      servers.rust-analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
        settings.cargo.features = "all";
      };

      # servers.nil_ls.enable = true;
      # servers.nixd.enable = true;

      servers.ts_ls.enable = true;

      servers.phpactor.enable = true;

      servers.ols.enable = true;

      # servers.prismals.enable = true;

      servers.pyright.enable = true;

      servers.gopls.enable = true;

      servers.volar.enable = true;

      servers.astro.enable = true;

      # servers.ccls.enable = true;
      servers.clangd.enable = true;

      servers.zls.enable = true;

      keymaps = {
        lspBuf = {
          "<F2>" = "rename";
          "<C-Space>" = "hover";
          "<Leader>df" = "definition";
          "<Leader>dc" = "declaration";
          "<Leader>ca" = "code_action";
        };
        diagnostic = {
          "<Leader>ee" = "open_float";
          "<Leader>ej" = "goto_next";
          "<Leader>ek" = "goto_prev";
        };
      };
    };

    plugins.nvim-jdtls = {
      enable = true;
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
      settings.formatters_by_ft = {
        javascript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescript = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        go = [
          "goimports"
          "gofmt"
        ];
        rust = [ "rustfmt" ];
        json = [ "jq" ];
        lua = [ "stylua" ];
      };

      # TODO
      # <leader> fm
    };
  };
}
