{
  lib,
  config,
  ...
}: {
  options.desktop.status-bar.eww = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.status-bar.eww.enable {
    programs.eww = {
      enable = true;
      configDir = ./config/eww;
    };
  };
}
