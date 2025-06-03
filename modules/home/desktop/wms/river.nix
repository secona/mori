{
  lib,
  config,
  ...
}:
{
  options.desktop.wms.river = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.wms.river.enable {
    desktop.utils.ctl.enable = true;
    desktop.files.nemo.enable = true;
    desktop.launcher.wofi.enable = true;
    desktop.notifications.swaync.enable = true;
    desktop.ui.gtk.enable = true;
    desktop.utils.wlogout.enable = true;

    wayland.windowManager.river = {
      enable = true;
      settings = {
        map = {
          normal = {
            "Super R" = "spawn \"wofi -show drun\"";
          };
        };
      };
    };
  };
}
