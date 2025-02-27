{
  pkgs,
  lib,
  config,
  ...
}: {
  options.dev.bruno = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.dev.bruno.enable {
    home.packages = [pkgs.bruno];
  };
}
