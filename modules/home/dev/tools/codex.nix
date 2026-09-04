{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.dev.tools.codex = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.codex.enable {
    programs.codex.enable = true;
    programs.codex.package = pkgs.unstable.codex;
  };
}
