{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.tools.burpsuite = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.burpsuite.enable {
    home.packages = [pkgs.burpsuite];
  };
}

