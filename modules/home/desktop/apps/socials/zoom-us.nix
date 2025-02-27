{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.socials.zoom-us = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.socials.zoom-us.enable {
    home.packages = [pkgs.zoom-us];
  };
}
