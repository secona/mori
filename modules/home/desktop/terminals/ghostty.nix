{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.desktop.terminals.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.desktop.terminals.ghostty.enable {
    programs.ghostty = {
      enable = true;
      settings.font-size = 10;
    };
  };
}
