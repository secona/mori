{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.misc.pinta = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.misc.pinta.enable {
    home.packages = with pkgs; [ pinta ];
  };
}
