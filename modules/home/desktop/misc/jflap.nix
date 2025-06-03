{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.misc.jflap = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.misc.jflap.enable {
    home.packages = with pkgs; [ jflap ];
  };
}
