{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.misc.jflap = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.misc.jflap.enable {
    home.packages = with pkgs; [jflap];
  };
}
