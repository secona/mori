{
  pkgs,
  lib,
  config,
  ...
}: {
  options.terminals.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = lib.mkIf config.terminals.ghostty.enable {
    home.packages = [pkgs.ghostty];
  };
}
