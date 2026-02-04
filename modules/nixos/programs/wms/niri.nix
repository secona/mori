{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.nixos.programs.wms.niri = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.nixos.programs.wms.niri.enable {
    programs.niri.enable = true;
    services.noctalia-shell.enable = true;

    # gnome-keyring is required for xdg-desktop-portal-gnome to work properly
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config.niri = {
        default = [
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [
          "gnome"
        ];
        "org.freedesktop.impl.portal.Screenshot" = [
          "gnome"
        ];
      };
    };
  };
}
