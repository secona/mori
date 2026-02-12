{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.media.vlc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.vlc.enable {
    xdg.mimeApps = {
      defaultApplications = {
        "audio/mp4" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
      };
    };

    home.packages = [ pkgs.vlc ];
  };
}
