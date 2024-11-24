{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.libreoffice = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.apps.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
