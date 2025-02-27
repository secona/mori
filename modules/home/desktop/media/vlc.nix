{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.media.vlc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.vlc.enable {
    home.packages = [pkgs.vlc];
  };
}
