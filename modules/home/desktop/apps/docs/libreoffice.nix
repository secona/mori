{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.docs.libreoffice = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.docs.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
