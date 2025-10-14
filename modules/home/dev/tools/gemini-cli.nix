{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.gemini-cli = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.gemini-cli.enable {
    home.packages = [ pkgs.unstable.gemini-cli ];
  };
}
