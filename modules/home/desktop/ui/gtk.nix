{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.ui.gtk = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.ui.gtk.enable {
    gtk = {
      enable = true;

      iconTheme = lib.mkDefault {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };

      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
