{ ... }:

{
  plugins.treesitter = {
    enable = true;
    indent = true;
  };

  plugins.treesitter-context = {
    enable = true;
    settings = {
      mode = "topline";
    };
    # TODO
    # color of line
  };

  plugins.rainbow-delimiters = {
    enable = true;
  };

  plugins.ts-autotag = {
    enable = true;
  };
}