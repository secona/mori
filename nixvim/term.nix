{...}: {
  plugins.toggleterm = {
    enable = true;
    settings = {
      float_opts.border = "rounded";
      direction = "float";
      open_mapping = "[[<C-_>]]";
      shell = "zsh";
    };
  };
}
