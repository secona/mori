{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.docs.libreoffice = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.docs.libreoffice.enable {
    home.packages = [pkgs.libreoffice];
  };
}
