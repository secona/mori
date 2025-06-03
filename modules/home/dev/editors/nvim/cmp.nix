{ ... }:
{
  programs.nixvim = {
    plugins.cmp-buffer.enable = true;
    plugins.cmp-path.enable = true;
    plugins.cmp_luasnip.enable = true;
    plugins.luasnip.enable = true;
    plugins.lspkind.enable = true;
    plugins.nvim-autopairs.enable = true;

    plugins.cmp = {
      enable = true;
      settings = {
        window = {
          completion = {
            border = "rounded";
            scrollbar = true;
          };
          documentation = {
            border = "rounded";
          };
        };
        mapping.__raw = ''
          cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                  cmp.confirm()
                end
              else
                fallback()
              end
            end, { "i", "s", "c" }),
            ["<CR>"] = cmp.mapping({
              i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                  cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                  fallback()
                end
              end,
              s = cmp.mapping.confirm({ select = true }),
              c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
            }),
            ["<C-Space>"] = cmp.mapping.complete(),
          })
        '';
        sources = [
          { name = "cmp_luasnip"; }
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
        snippet = {
          expand = ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end
          '';
        };
      };
    };
  };
}
