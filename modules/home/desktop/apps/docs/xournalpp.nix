{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.docs.xournalpp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.docs.xournalpp.enable {
    home.packages = [pkgs.xournalpp];
  };
}
