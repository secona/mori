{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.utils.ctl = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.utils.ctl.enable {
    home.packages = with pkgs; [
      playerctl
      brightnessctl
    ];
  };
}
