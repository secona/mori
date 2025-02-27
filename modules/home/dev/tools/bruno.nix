{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.tools.bruno = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.tools.bruno.enable {
    home.packages = [pkgs.bruno];
  };
}
