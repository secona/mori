{
  lib,
  config,
  ...
}:
{
  options.desktop.notifications.dunst = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.notifications.dunst.enable {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          origin = "top-center";
          corner_radius = 12;
        };
      };
    };
  };
}
