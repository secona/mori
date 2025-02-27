{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.libreoffice = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
