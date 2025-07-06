{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.media.spotify-player = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.spotify-player.enable {
    programs.spotify-player = {
      enable = true;
    };
  };
}
