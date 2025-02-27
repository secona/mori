{
  pkgs,
  lib,
  config,
  ...
}: {
  options.apps.discord = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.apps.discord.enable {
    home.packages = [pkgs.discord];
  };
}
