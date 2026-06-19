{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.dev.tools.nsys-ui = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.nsys-ui.enable {
    home.packages = [ pkgs.unstable.cudaPackages.nsight_systems ];
  };
}
