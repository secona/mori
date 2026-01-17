{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.docs.zotero = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.docs.zotero.enable {
    home.packages = [ pkgs.zotero ];
  };
}
