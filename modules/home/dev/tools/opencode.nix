{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.dev.tools.opencode = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.opencode.enable {
    programs.opencode.enable = true;
    programs.opencode.package = pkgs.unstable.opencode;
    programs.opencode.settings.theme = "catppuccin";
  };
}
