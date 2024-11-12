{lib, config, inputs, ...}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options.ui.catppuccin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.ui.catppuccin.enable {
    catppuccin = {
      flavor = "mocha";
      enable = true;
      pointerCursor.enable = true;
      pointerCursor.accent = "dark";
    };
  };
}
