{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options.desktop.ui.catppuccin = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.ui.catppuccin.enable {
    catppuccin = {
      flavor = "mocha";
      enable = true;
      cursors.enable = true;
      cursors.accent = "dark";
    };
  };
}
