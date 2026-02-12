{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.media.loupe = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.media.loupe.enable {
    xdg.mimeApps.defaultApplications = {
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
    };

    home.packages = [ pkgs.loupe ];
  };
}
