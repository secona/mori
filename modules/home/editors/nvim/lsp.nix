{pkgs-unstable, ...}: {
  programs.nixvim = {
    plugins.rustaceanvim = {
      enable = true;
      rustAnalyzerPackage = pkgs-unstable.rust-analyzer;
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

      # servers.rust-analyzer = {
      #   enable = true;
      #   installCargo = false;
      #   installRustc = false;
      #   settings.cargo.features = "all";
      # };

      servers.nil-ls.enable = true;

      servers.tsserver.enable = true;

      servers.phpactor.enable = true;

      servers.prismals.enable = true;

      servers.pyright.enable = true;

      servers.gopls.enable = true;

      servers.volar.enable = true;

      servers.astro.enable = true;

      servers.ccls.enable = true;

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
      data = "/tmp/jdtls";
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
        javascript = ["prettier"];
        javascriptreact = ["prettier"];
        typescript = ["prettier"];
        typescriptreact = ["prettier"];
        go = ["goimports" "gofmt"];
        rust = ["rustfmt"];
        json = ["jq"];
        lua = ["stylua"];
      };

      # TODO
      # <leader> fm
    };
  };
}
