{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.media.vlc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.media.vlc.enable {
    home.packages = [pkgs.vlc];
  };
}
