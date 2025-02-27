{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.google-chrome = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.google-chrome.enable {
    home.packages = [pkgs.google-chrome];
  };
}
