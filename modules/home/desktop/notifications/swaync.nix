{
  lib,
  config,
  ...
}:
{
  options.desktop.notifications.swaync = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.notifications.swaync.enable {
    services.swaync = {
      enable = true;
      # style = builtins.readFile ../../../../config/swaync/style.css;
      settings = {
        positionY = "bottom";
      };
    };
  };
}
