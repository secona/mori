{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.zoom-us = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.zoom-us.enable {
    home.packages = [pkgs.zoom-us];
  };
}
