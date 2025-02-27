{
  pkgs,
  lib,
  config,
  ...
}: {
  options.desktop.apps.terminals.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.apps.terminals.ghostty.enable {
    home.packages = [pkgs.ghostty];
  };
}
