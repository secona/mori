{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.media.flameshot = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.flameshot.enable {
    home.packages = [ pkgs.flameshot ];
  };
}
