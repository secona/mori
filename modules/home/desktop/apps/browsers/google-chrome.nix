{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.browsers.google-chrome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.browsers.google-chrome.enable {
    home.packages = [pkgs.google-chrome];
  };
}
