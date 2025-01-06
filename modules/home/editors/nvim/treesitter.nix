{...}: {
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings.indent.enable = true;
    };

    plugins.treesitter-context = {
      enable = true;
      settings = {
        mode = "topline";
        on_attach = ''
          function()
            vim.cmd([[ hi TreesitterContextBottom gui=underline guisp=#cba6f7 ]])
          end
        '';
      };
    };

    plugins.rainbow-delimiters = {
      enable = true;
    };

    plugins.ts-autotag = {
      enable = true;
    };
  };
}
