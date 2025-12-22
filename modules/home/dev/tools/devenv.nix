{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.devenv = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.devenv.enable {
    home.packages = [ pkgs.devenv ];
  };
}
