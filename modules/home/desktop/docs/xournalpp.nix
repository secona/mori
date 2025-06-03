{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.docs.xournalpp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.docs.xournalpp.enable {
    home.packages = [ pkgs.xournalpp ];
  };
}
